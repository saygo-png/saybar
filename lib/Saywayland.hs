{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE UndecidableInstances #-}

{- HLINT ignore "Use camelCase" -}

module Saywayland (module Saywayland) where

import Control.Concurrent (threadDelay)
import Data.Binary
import Data.Binary.Get hiding (remaining)
import Data.Binary.Put
import Data.Bits
import Data.ByteString qualified as BS
import Data.ByteString.Lazy qualified as BSL
import Data.ByteString.Lazy.Internal qualified as BSL
import Data.Map qualified as Map
import GHC.Generics
import Network.Socket (Family (AF_UNIX), SockAddr (SockAddrUnix), Socket, SocketType (Stream), connect, defaultProtocol, socket)
import Network.Socket.ByteString (sendManyWithFds)
import Network.Socket.ByteString.Lazy (recv, sendAll)
import Relude hiding (ByteString, get, put)
import SaywaylandTH
import System.Console.ANSI (Color (..), ColorIntensity (..), ConsoleLayer (..), SGR (..), hNowSupportsANSI, setSGRCode)
import System.Environment (getEnv)
import System.Posix.Types (Fd)
import Text.Printf (PrintfArg, printf)

-- Types {{{

-- Wire types
type WlString = BSL.ByteString

type WlID = Word32

type WlUint = Word32

type WlInt = Int32

-- | Every interface that can appear as the object of a Wayland event.
data WaylandInterface
  = WlSurface
  | WlShmPool
  | WlBuffer
  | WlCompositor
  | ZwlrLayerSurfaceV1
  | ZwlrLayerShellV1
  | WlDisplay
  | WlRegistry
  | WlShm
  | WlOutput
  | ExtWorkspaceManagerV1
  | ExtWorkspaceHandleV1
  | ExtWorkspaceGroupHandleV1
  deriving stock (Show)

type role ObjectID phantom

newtype ObjectID (a :: WaylandInterface) = ObjectID {id :: WlID}
  deriving newtype (PrintfArg, Num, Show)

type role WlArray representational

newtype WlArray a = WlArray [a]
  deriving stock (Show)

type role LittleEndian representational

newtype LittleEndian a = LittleEndian a

-- | Type representing Wayland color formats.
data WlColorFormat
  = Argb8888
  | Xrgb8888
  | UnknownColorFormat WlUint
  deriving stock (Eq, Ord, Show)

instance Binary WlColorFormat where
  put :: WlColorFormat -> Put
  put =
    putWord32le . \case
      Argb8888 -> 0
      Xrgb8888 -> 1
      UnknownColorFormat uint -> uint

  get :: Get WlColorFormat
  get =
    getWord32le >>= \case
      0 -> pure Argb8888
      1 -> pure Xrgb8888
      n -> pure $ UnknownColorFormat n

$( declareEvents
     --
     [ event "WlDisplay" 0 "error" [("errorObjectID", ty ''WlID), ("errorCode", ty ''WlUint), ("errorMessage", ty ''WlString)]
     , event "WlDisplay" 1 "deleteID" [("deletedID", ty ''WlID)]
     , --
       event "WlRegistry" 0 "global" [("name", ty ''WlUint), ("interface", ty ''WlString), ("version", ty ''WlUint)]
     , --
       event "WlShm" 0 "format" [("format", ty ''Word32)]
     , --
       event "ZwlrLayerSurfaceV1" 0 "configure" [("serial", ty ''WlUint), ("width", ty ''WlUint), ("height", ty ''WlUint)]
     , --
       event "ExtWorkspaceManagerV1" 0 "workspaceGroup" [("handleID", appTy ''ObjectID 'ExtWorkspaceGroupHandleV1)]
     , event "ExtWorkspaceManagerV1" 1 "workspace" [("handleID", appTy ''ObjectID 'ExtWorkspaceHandleV1)]
     , event "ExtWorkspaceManagerV1" 2 "done" []
     , --
       event "ExtWorkspaceHandleV1" 0 "id" [("id", ty ''WlString)]
     , event "ExtWorkspaceHandleV1" 1 "name" [("name", ty ''WlString)]
     , event "ExtWorkspaceHandleV1" 2 "coordinates" [("coordinates", appTy ''WlArray ''Word32)]
     , event "ExtWorkspaceHandleV1" 3 "state" [("state", ty ''Word32)]
     , event "ExtWorkspaceHandleV1" 4 "capabilities" [("capabilities", ty ''Word32)]
     , event "ExtWorkspaceHandleV1" 5 "removed" []
     , --
       event "ExtWorkspaceGroupHandleV1" 0 "capabilities" [("capabilities", ty ''WlUint)]
     , event "ExtWorkspaceGroupHandleV1" 1 "output_enter" [("output", appTy ''ObjectID 'WlOutput)]
     , event "ExtWorkspaceGroupHandleV1" 2 "output_leave" [("output", appTy ''ObjectID 'WlOutput)]
     , event "ExtWorkspaceGroupHandleV1" 3 "workspace_enter" [("workspace", appTy ''ObjectID 'ExtWorkspaceHandleV1)]
     , event "ExtWorkspaceGroupHandleV1" 4 "workspace_leave" [("workspace", appTy ''ObjectID 'ExtWorkspaceHandleV1)]
     , event "ExtWorkspaceGroupHandleV1" 5 "removed" []
     , --
       event "WlBuffer" 0 "release" []
     ]
 )

-- | Globals storage by name.
type Globals = Map WlUint (Header, BodyWlRegistry_global)

-- | Type representing a Wayland serial code with some context.
data Serial = Serial
  { serialCode :: WlUint
  -- ^ The serial code itself
  , originInterface :: WaylandInterface
  -- ^ The interface that the serial code originated from.
  , originID :: WlID
  -- ^ The ID of object that the serial code originated from.
  }

data WaylandEnv = WaylandEnv
  { socket :: Socket
  -- ^ The connected UNIX socket.
  , counter :: IORef WlID
  -- ^ Counter used for generating unique object IDs.
  , globals :: IORef Globals
  -- ^ Map of received globals. Globals might be removed.
  , objects :: IORef (Map WlID WaylandInterface)
  -- ^ Map of existing objects. Objects might be removed.
  , serial :: TMVar WlUint
  , freeBuffer :: MVar ()
  , eventHandlers :: IORef [WaylandEvent -> Wayland ()]
  }

type Wayland = ReaderT WaylandEnv IO

-- | Type representing a Wayland buffer.
data Buffer = Buffer
  { id :: ObjectID 'WlBuffer
  , offset :: WlInt
  -- ^ Memory offset of the buffer.
  }

-- | Type representing a Wayland header.
data Header = Header
  { objectID :: WlID
  , opCode :: Word16
  {- ^ Operation codes in Wayland are 0 indexed, separate for events and requests.
  They are numbered based on the order of appearance in the protocol.
  -}
  , size :: Word16
  }
  deriving stock (Show)

instance Binary Header where
  put :: Header -> Put
  put header = do
    putWord32le header.objectID
    putWord16le header.opCode
    putWord16le header.size
  get :: Get Header
  get = Header <$> getWord32le <*> getWord16le <*> getWord16le

instance ToString Header where
  toString :: Header -> String
  toString (Header objectID opCode size) =
    printf "-- wl_header: objectID=%i opCode=%i size=%i" objectID opCode size

-- }}}

-- Requests {{{
wlDisplay_getRegistry :: Wayland (ObjectID 'WlRegistry)
wlDisplay_getRegistry = do
  env <- ask
  registryID <- nextID env.counter
  -- The object here is actually saved before the request is sent
  -- This is because the registry id is needed for parsing its requests/events
  modifyIORef env.objects (Map.insert registryID WlRegistry)
  let messageBody = runPut $ putWord32le registryID
  liftIO . sendAll env.socket $ mkMessage wlDisplayID 1 messageBody
  liftIO . strReq ("wl_display", wlDisplayID, "get_registry") $ printf "wl_registry=%i" registryID
  return $ coerce registryID

wlShm_createPool :: ObjectID 'WlShm -> Fd -> WlInt -> Wayland (ObjectID 'WlShmPool)
wlShm_createPool wlShmID fileDescriptor poolSize = do
  env <- ask
  newObjectID <- nextID env.counter
  let messageBody = runPut $ do
        putWord32le newObjectID
        putInt32le poolSize
  let msg = BS.toStrict $ mkMessage wlShmID 0 messageBody
  liftIO $ sendManyWithFds env.socket [msg] [fileDescriptor]

  let sender = ("wl_shm", wlShmID, "create_pool")
  liftIO . strReq sender $ printf "newID=%i fd=%s size=%i" newObjectID (show @Text fileDescriptor) poolSize
  modifyIORef env.objects (Map.insert newObjectID WlShmPool)
  return $ coerce newObjectID

wlSurface_attach :: ObjectID 'WlSurface -> ObjectID 'WlBuffer -> Wayland ()
wlSurface_attach wlSurfaceID wlBufferID = do
  env <- ask
  let messageBody = runPut $ do
        putWord32le $ coerce wlBufferID
        -- x y arguments have to be set to 0
        putInt32le 0
        putInt32le 0
  liftIO . sendAll env.socket $ mkMessage wlSurfaceID 1 messageBody
  pure ()

wlSurface_damageBuffer :: ObjectID 'WlSurface -> WlInt -> WlInt -> WlInt -> WlInt -> Wayland ()
wlSurface_damageBuffer wlSurfaceID x y width height = do
  env <- ask
  let messageBody = runPut $ do
        putInt32le x
        putInt32le y
        putWord32le $ fromIntegral width
        putWord32le $ fromIntegral height
  liftIO . sendAll env.socket $ mkMessage wlSurfaceID 9 messageBody
  pure ()

wlSurface_commit :: ObjectID 'WlSurface -> Wayland ()
wlSurface_commit wlSurfaceID = do
  env <- ask
  let messageBody = runPut mempty
  liftIO . sendAll env.socket $ mkMessage wlSurfaceID 6 messageBody
  pure ()

zwlrLayerShellV1_getLayerSurface :: ObjectID 'ZwlrLayerShellV1 -> ObjectID 'WlSurface -> Word32 -> BSL.ByteString -> Wayland (ObjectID 'ZwlrLayerSurfaceV1)
zwlrLayerShellV1_getLayerSurface zwlrLayerShellV1ID wlSurfaceID layer namespace = do
  env <- ask
  newObjectID <- nextID env.counter
  let messageBody = runPut $ do
        putWord32le newObjectID
        putWord32le $ coerce wlSurfaceID
        putWord32le waylandNull
        putWord32le layer
        putWlString namespace
  liftIO . sendAll env.socket $ mkMessage zwlrLayerShellV1ID 0 messageBody

  let sender = ("zwlr_layer_shell_v1", zwlrLayerShellV1ID, "get_layer_surface")
  liftIO
    . strReq sender
    $ printf "newID=%i wl_surface=%i output=%i layer=%i namespace=%s" newObjectID wlSurfaceID waylandNull layer (BSL.unpackChars namespace)

  modifyIORef env.objects (Map.insert newObjectID ZwlrLayerSurfaceV1)
  return $ coerce newObjectID

zwlrLayerSurfaceV1_setAnchor :: ObjectID 'ZwlrLayerSurfaceV1 -> WlUint -> Wayland ()
zwlrLayerSurfaceV1_setAnchor zwlrLayerSurfaceV1ID anchor = do
  env <- ask
  let messageBody = runPut $ putWord32le anchor
  liftIO $ sendAll env.socket $ mkMessage zwlrLayerSurfaceV1ID 1 messageBody
  let sender = ("zwlr_layer_surface_v1", zwlrLayerSurfaceV1ID, "set_anchor")
  liftIO . strReq sender $ "anchor=" <> show anchor

zwlrLayerSurfaceV1_setSize :: ObjectID 'ZwlrLayerSurfaceV1 -> WlUint -> WlUint -> Wayland ()
zwlrLayerSurfaceV1_setSize zwlrLayerSurfaceV1ID width height = do
  env <- ask
  let messageBody = runPut $ do
        putWord32le width
        putWord32le height
  liftIO . sendAll env.socket $ mkMessage zwlrLayerSurfaceV1ID 0 messageBody
  let sender = ("zwlr_layer_surface_v1", zwlrLayerSurfaceV1ID, "set_size")
  liftIO . strReq sender $ "width=" <> show width <> "height=" <> show height

zwlrLayerSurfaceV1_ackConfigure :: ObjectID 'ZwlrLayerSurfaceV1 -> Wayland ()
zwlrLayerSurfaceV1_ackConfigure zwlrLayerSurfaceV1ID = do
  env <- ask
  serial <- atomically $ takeTMVar env.serial
  let messageBody = runPut $ do putWord32le serial
  liftIO . sendAll env.socket $ mkMessage zwlrLayerSurfaceV1ID 6 messageBody
  let sender = ("zwlr_layer_surface_v1", zwlrLayerSurfaceV1ID, "ack_configure")
  liftIO . strReq sender $ "serial=" <> show serial

zwlrLayerSurfaceV1_setExclusiveZone :: ObjectID 'ZwlrLayerSurfaceV1 -> WlInt -> Wayland ()
zwlrLayerSurfaceV1_setExclusiveZone zwlrLayerSurfaceV1ID zone = do
  env <- ask
  let messageBody = runPut $ do putInt32le zone
  liftIO $ sendAll env.socket $ mkMessage zwlrLayerSurfaceV1ID 2 messageBody
  let sender = ("zwlr_layer_surface_v1", zwlrLayerSurfaceV1ID, "set_exclusive_zone")
  liftIO . strReq sender $ printf "zone=%i" zone

wlShmPool_createBuffer :: ObjectID 'WlShmPool -> WlInt -> WlInt -> WlInt -> WlInt -> WlColorFormat -> Wayland Buffer
wlShmPool_createBuffer wlShmPoolID offset bufferWidth bufferHeight colorChannels colorFormat = do
  env <- ask
  newObjectID <- nextID env.counter
  let messageBody = runPut $ do
        putWord32le newObjectID
        putInt32le offset
        putInt32le bufferWidth
        putInt32le bufferHeight
        putInt32le $ bufferWidth * colorChannels -- Stride
        put colorFormat
  liftIO . sendAll env.socket $ mkMessage wlShmPoolID 0 messageBody
  let sender = ("wl_shm_pool", wlShmPoolID, "create_buffer")
  liftIO . strReq sender $ printf "newID=%i" newObjectID
  modifyIORef env.objects (Map.insert newObjectID WlBuffer)
  return $ Buffer (coerce newObjectID) offset

wlRegistry_bind :: ObjectID 'WlRegistry -> WaylandInterface -> WlUint -> WlString -> WlUint -> WlID -> Wayland (ObjectID a)
wlRegistry_bind registryID waylandInterface globalName interfaceName interfaceVersion newObjectID = do
  env <- ask
  let messageBody = runPut $ do
        putWord32le globalName
        putWlString interfaceName
        putWord32le interfaceVersion
        putWord32le newObjectID
  liftIO $ sendAll env.socket $ mkMessage registryID 0 messageBody
  let sender = ("wl_registry", registryID, "bind")
  liftIO
    . strReq sender
    $ mconcat
      [ "name="
      , show globalName
      , " interface="
      , BSL.unpackChars interfaceName
      , " version="
      , show interfaceVersion
      , "id="
      , show newObjectID
      ]

  modifyIORef env.objects (Map.insert newObjectID waylandInterface)
  return $ coerce newObjectID

wlCompositor_createSurface :: ObjectID 'WlCompositor -> Wayland (ObjectID 'WlSurface)
wlCompositor_createSurface wlCompositorID = do
  env <- ask
  newObjectID <- nextID env.counter
  let messageBody = runPut $ putWord32le newObjectID
  liftIO $ sendAll env.socket $ mkMessage wlCompositorID 0 messageBody
  let sender = ("wl_compositor", wlCompositorID, "create_surface")
  liftIO . strReq sender $ printf "newID=%i" newObjectID
  modifyIORef env.objects (Map.insert newObjectID WlSurface)
  return $ coerce newObjectID

-- }}}

-- Event helpers {{{

-- | Format a received event as a pretty string.
formatEvent :: WaylandEvent -> String
formatEvent = \case
  EvWlDisplay_error h e -> fmt "wl_display" h $ "error: object_id=" <> show e.errorObjectID <> " code=" <> show e.errorCode <> " message=" <> BSL.unpackChars e.errorMessage
  EvWlDisplay_deleteID h e -> fmt "wl_display" h $ "delete_id: id=" <> show e.deletedID
  EvWlRegistry_global h e -> fmt "wl_registry" h $ "global: name=" <> show e.name <> " interface=" <> BSL.unpackChars e.interface <> " version=" <> show e.version
  EvWlShm_format h e -> fmt "wl_shm" h $ "format: format=" <> show e.format <> " (" <> show e.format <> ")"
  EvZwlrLayerSurfaceV1_configure h e -> fmt "zwlr_layer_surface_v1" h $ "configure: serial=" <> show e.serial <> " width=" <> show e.width <> " height=" <> show e.height
  EvExtWorkspaceManagerV1_workspace h e -> fmt "ext_workspace_manager_v1" h $ "workspace: handle=" <> show e.handleID
  EvExtWorkspaceManagerV1_workspaceGroup h e -> fmt "ext_workspace_manager_v1" h $ "workspace_group: handle=" <> show e.handleID
  EvExtWorkspaceManagerV1_done h _ -> fmt "ext_workspace_manager_v1" h "done: done sending workspace info"
  EvExtWorkspaceHandleV1_id h e -> fmt "ext_workspace_handle_v1" h $ "id: id=" <> BSL.unpackChars e.id
  EvExtWorkspaceHandleV1_name h e -> fmt "ext_workspace_handle_v1" h $ "name: name=" <> BSL.unpackChars e.name
  EvExtWorkspaceHandleV1_coordinates h e -> fmt "ext_workspace_handle_v1" h $ "coordinates: coordinates=" <> show e.coordinates
  EvExtWorkspaceHandleV1_state h e -> fmt "ext_workspace_handle_v1" h $ "state: state=" <> show e.state
  EvExtWorkspaceHandleV1_capabilities h e -> fmt "ext_workspace_handle_v1" h $ "capabilities: capabilities=" <> show e.capabilities
  EvExtWorkspaceHandleV1_removed h _ -> fmt "ext_workspace_handle_v1" h "removed: removed"
  EvExtWorkspaceGroupHandleV1_capabilities h e -> fmt "ext_workspace_group_handle_v1" h $ "capabilities: capabilities=" <> show e.capabilities
  EvExtWorkspaceGroupHandleV1_output_enter h e -> fmt "ext_workspace_group_handle_v1" h $ "output_enter: output=" <> show e.output
  EvExtWorkspaceGroupHandleV1_output_leave h e -> fmt "ext_workspace_group_handle_v1" h $ "output_leave: output=" <> show e.output
  EvExtWorkspaceGroupHandleV1_workspace_enter h e -> fmt "ext_workspace_group_handle_v1" h $ "workspace_enter: workspace=" <> show e.workspace
  EvExtWorkspaceGroupHandleV1_workspace_leave h e -> fmt "ext_workspace_group_handle_v1" h $ "workspace_leave: workspace=" <> show e.workspace
  EvExtWorkspaceGroupHandleV1_removed h _ -> fmt "ext_workspace_group_handle_v1" h "removed: removed"
  EvWlBuffer_release h _ -> fmt "wl_buffer" h "release: buffer released"
  EvUnknown h -> "UNKNOWN EVENT: objectID=" <> show h.objectID <> " opCode=" <> show h.opCode <> " size=" <> show h.size
  where
    fmt :: String -> Header -> String -> String
    fmt interface h details = interface <> "@" <> show h.objectID <> "." <> details

-- }}}

-- Event loop {{{

-- | Core event loop. It reads the socket and processes the data using 'processBuffer'
eventLoop :: Wayland ()
eventLoop = do
  env <- ask
  msg <- liftIO $ receiveSocketData env.socket
  unless (BSL.null msg) $ processBuffer (BS.toStrict msg)
  eventLoop

{- | Processes the data from the wayland socket.
It does nothing if the data is partial and waits for the next call.
If the data is not partial, it parses events with 'parseEvent'
then for each event it calls 'formatEvent' and 'handleEventResponse'
-}
processBuffer :: BS.ByteString -> Wayland ()
processBuffer bytes = do
  env <- ask
  objects <- liftIO $ readIORef env.objects
  case pushChunk (runGetIncremental (parseEvent objects)) bytes of
    Done remaining _ ev -> do
      liftIO $ case ev of
        EvWlBuffer_release _ _ -> pure ()
        _ -> displayEvent ev
      handleEventResponse ev
      unless (BS.null remaining) $ processBuffer remaining
    Partial _ ->
      return ()
    Fail _ _ err ->
      liftIO $ putStrLn $ "Parse error: " <> err
  where
    displayEvent :: WaylandEvent -> IO ()
    displayEvent ev = putStrLn $ "<- " <> formatEvent ev

{- | Event handler.
Assigns objects, globals and performs other actions based on events.
It also processes events through custom handlers defined by 'onEvent', after the internal ones.
-}
handleEventResponse :: WaylandEvent -> Wayland ()
handleEventResponse ev = do
  case ev of
    (EvWlBuffer_release _ _) -> takeMVar =<< asks (.freeBuffer)
    (EvWlRegistry_global h body) -> do
      globals <- asks (.globals)
      modifyIORef globals $ Map.insert body.name (h, body)
    (EvZwlrLayerSurfaceV1_configure _ body) -> do
      serial <- asks (.serial)
      atomically $ putTMVar serial body.serial
    (EvExtWorkspaceManagerV1_workspace _ body) -> do
      objects <- asks (.objects)
      modifyIORef objects $ Map.insert (coerce body.handleID) ExtWorkspaceHandleV1 -- This is stupid
    (EvExtWorkspaceManagerV1_workspaceGroup _ body) -> do
      objects <- asks (.objects)
      modifyIORef objects $ Map.insert (coerce body.handleID) ExtWorkspaceGroupHandleV1 -- This is stupid
    _ -> return ()

  handlers <- liftIO . readIORef =<< asks (.eventHandlers)
  mapM_ ($ ev) handlers

{- | Register a handler to be called on every incoming Wayland event.
Handlers are called in registration order after the library's own handlers.

Example:

> onEvent $ \case
>   EvExtWorkspaceHandleV1_name h e ->
>     liftIO $ modifyIORef myRef (Map.insert h.objectID (decodeUtf8 e.name))
>   _ -> pure ()
-}
onEvent :: (WaylandEvent -> Wayland ()) -> Wayland ()
onEvent handler = do
  handlersRef <- asks (.eventHandlers)
  liftIO $ modifyIORef handlersRef (handler :)

-- }}}

-- Vibecoded generic little-endian Binary deriving {{{

type GBinaryLE :: forall {k}. (k -> Type) -> Constraint
class GBinaryLE f where
  ggetLE :: Get (f a)
  gputLE :: f a -> Put

instance GBinaryLE U1 where
  ggetLE = return U1
  gputLE U1 = return ()

instance (GBinaryLE a, GBinaryLE b) => GBinaryLE (a :*: b) where
  ggetLE = (:*:) <$> ggetLE <*> ggetLE
  gputLE (a :*: b) = gputLE a *> gputLE b

instance (GBinaryLE a) => GBinaryLE (M1 i c a) where
  ggetLE = M1 <$> ggetLE
  gputLE (M1 x) = gputLE x

instance GBinaryLE (K1 i Word32) where
  ggetLE = K1 <$> getWord32le
  gputLE (K1 x) = putWord32le x

instance GBinaryLE (K1 i (ObjectID a)) where
  ggetLE = K1 <$> coerce getWord32le
  gputLE (K1 x) = putWord32le $ coerce x

instance GBinaryLE (K1 i Int32) where
  ggetLE = K1 <$> getInt32le
  gputLE (K1 x) = putInt32le x

instance GBinaryLE (K1 i WlString) where
  ggetLE = K1 <$> getWlString
  gputLE (K1 x) = putWlString x

instance GBinaryLE (K1 i (WlArray Word32)) where
  ggetLE = do
    len <- getWord32le
    bytes <- getLazyByteString $ padLen len
    let elems = runGet (replicateM (fromIntegral len `div` 4) getWord32le) bytes
    return $ K1 (WlArray elems)
  gputLE (K1 (WlArray xs)) = do
    let len = fromIntegral (Relude.length xs * 4) :: Word32
    putWord32le len
    mapM_ putWord32le xs

instance (Generic a, GBinaryLE (Rep a)) => Binary (LittleEndian a) where
  get = LittleEndian . to <$> ggetLE
  put (LittleEndian x) = gputLE (from x)

-- }}}

-- Utils {{{

{- | Bind to a Wayland interface. It looks at the advertised globals to find an interface.
If it fails it recurses. It does this 10 times with a small delay.
Prints an exception and exits with a fail if the interface is not found within 10 tries.
-}
bindToInterface :: ObjectID 'WlRegistry -> IORef Globals -> WlString -> WaylandInterface -> Wayland (ObjectID a)
bindToInterface registryID globalsRef targetInterface waylandInterface =
  let go (count :: Int) = do
        when
          (count >= 10)
          (putStrLn ("ERROR: the wayland global " <> BSL.unpackChars targetInterface <> " not found") >> exitFailure)
        liftIO $ printf "Trying to bind to %s... (%i)\n" (BSL.unpackChars targetInterface) count
        env <- ask
        globals <- readIORef globalsRef
        case findInterface globals of
          Nothing -> liftIO (threadDelay $ 100 * 1000) >> go (count + 1)
          Just e -> do
            newObjectID <- liftIO $ nextID env.counter
            wlRegistry_bind registryID waylandInterface e.name targetInterface e.version newObjectID
   in go 1
  where
    findInterface :: Globals -> Maybe BodyWlRegistry_global
    findInterface globals =
      let target = targetInterface <> "\0"
       in find (\(_, e) -> target `BSL.isPrefixOf` e.interface) globals >>= Just . snd

-- | Utility function for encoding and decoding Wayland strings.
padLen :: Word32 -> Int64
padLen l = (.&.) (fromIntegral l + 3) (-4)

-- | Encode a Wayland string type.
putWlString :: WlString -> Put
putWlString bs = do
  let str = bs <> "\0"
  putWord32le (fromIntegral $ BSL.length str)
  putLazyByteString str
  let paddingBytes = padLen (fromIntegral $ BSL.length str) - BSL.length str
  replicateM_ (fromIntegral paddingBytes) (putWord8 0)

-- | Decode a Wayland string type.
getWlString :: Get WlString
getWlString = do
  len <- getWord32le
  str <- getLazyByteString (fromIntegral len)
  skip $ fromIntegral (padLen len - fromIntegral len)
  return str

-- | The header size is always 8 in Wayland.
headerSize :: Int64
headerSize = 8

-- | Wayland null is just 0.
waylandNull :: Word32
waylandNull = 0

-- | wlDisplay always has ID 1 in Wayland.
wlDisplayID :: ObjectID 'WlDisplay
wlDisplayID = 1

{- | Convenience function for formatting events.
Events are colored in magenta following the wayland.app colorscheme.
-}
strReq :: (String, ObjectID a, String) -> String -> IO ()
strReq (object, objectID, method) text = do
  colorize <- getColorize
  putStrLn . colorize Vivid Magenta $ mconcat ["        -> ", object, "@", show objectID, ".", method, ": ", text]
  where
    getColorize :: (IsString s, Semigroup s) => IO (ColorIntensity -> Color -> s -> s)
    getColorize = do
      ansiSupport <- hNowSupportsANSI stdout
      pure
        $ if ansiSupport
          then \ci c t -> fromString (setSGRCode [SetColor Foreground ci c]) <> t <> fromString (setSGRCode [Reset])
          else const $ const id

{- | Convenience function for formatting a Wayland message.
It takes an objectID, operation code and a message body.
The header is generated based on this, the size is derived automatically.
-}
mkMessage :: ObjectID a -> Word16 -> BSL.ByteString -> BSL.ByteString
mkMessage objectID opCode messageBody =
  runPut $ do
    putWord32le $ coerce objectID
    putWord16le opCode
    putWord16le $ fromIntegral (headerSize + BSL.length messageBody)
    putLazyByteString messageBody

{- | Connect to the Wayland socket.
The socket path is $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY
-}
connectToWlSocket :: IO Socket
connectToWlSocket = do
  xdg_runtime_dir <- getEnv "XDG_RUNTIME_DIR"
  wayland_display <- getEnv "WAYLAND_DISPLAY"
  let path = xdg_runtime_dir <> "/" <> wayland_display
  sock <- socket AF_UNIX Stream defaultProtocol
  connect sock (SockAddrUnix path)
  return sock

-- | Receive data from the wayland socket.
receiveSocketData :: Socket -> IO BSL.ByteString
receiveSocketData sock = do
  liftIO $ recv sock 4096

{- | Generates a Wayland object ID from a counter.
It does this by incrementing the counter by 1.
-}
nextID :: (MonadIO m) => IORef WlID -> m WlID
nextID counter = do
  current <- readIORef counter
  modifyIORef counter (+ 1)
  return current

-- }}}

-- vim: foldmethod=marker
