{-# LANGUAGE DerivingVia #-}
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
import Relude hiding (ByteString, get)
import System.Console.ANSI (Color (..), ColorIntensity (..), ConsoleLayer (..), SGR (..), hNowSupportsANSI, setSGRCode)
import System.Environment (getEnv)
import System.Posix.Types (Fd)
import Text.Printf (PrintfArg, printf)

-- Types {{{

type Wayland = ReaderT WaylandEnv IO

type role ObjectID phantom

newtype ObjectID (a :: WaylandInterface) = ObjectID {id :: Word32}
  deriving newtype (PrintfArg, Num, Show)

type WlString = BSL.ByteString

type WlID = Word32

type WlUint = Word32

type WlInt = Int32

data Serial = Serial
  { serialCode :: Word32
  , originInterface :: WaylandInterface
  , originID :: Word32
  }

data WaylandEnv = WaylandEnv
  { socket :: Socket
  , counter :: IORef Word32
  , globals :: IORef Globals
  , objects :: IORef (Map Word32 WaylandInterface)
  , serial :: TMVar Word32
  , freeBuffer :: MVar ()
  }

data Buffer = Buffer
  { id :: ObjectID 'WlBuffer
  , offset :: WlInt
  }

data Header = Header
  { objectID :: Word32
  , opCode :: Word16
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

  -- let sender = ("wl_surface", wlSurfaceID, "attach")
  pure ()

-- liftIO . strReq sender $ printf "bufferId=%i x=%i y=%i" wlBufferID (0 :: Int32) (0 :: Int32)

wlSurface_damageBuffer :: ObjectID 'WlSurface -> WlInt -> WlInt -> WlInt -> WlInt -> Wayland ()
wlSurface_damageBuffer wlSurfaceID x y width height = do
  env <- ask
  let messageBody = runPut $ do
        putInt32le x
        putInt32le y
        putWord32le $ fromIntegral width
        putWord32le $ fromIntegral height
  liftIO . sendAll env.socket $ mkMessage wlSurfaceID 9 messageBody

  -- let sender = ("wl_surface", wlSurfaceID, "damage_buffer")
  pure ()

-- liftIO . strReq sender $ printf "x=%i y=%i width=%i height=%i" x y width height

wlSurface_commit :: ObjectID 'WlSurface -> Wayland ()
wlSurface_commit wlSurfaceID = do
  env <- ask

  let messageBody = runPut mempty
  liftIO . sendAll env.socket $ mkMessage wlSurfaceID 6 messageBody

  -- let sender = ("wl_surface", wlSurfaceID, "commit")
  pure ()

-- liftIO $ strReq sender "commit request"

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
  liftIO . strReq sender $ printf "anchor=%i" anchor

zwlrLayerSurfaceV1_setSize :: ObjectID 'ZwlrLayerSurfaceV1 -> WlUint -> WlUint -> Wayland ()
zwlrLayerSurfaceV1_setSize zwlrLayerSurfaceV1ID width height = do
  env <- ask

  let messageBody = runPut $ do
        putWord32le width
        putWord32le height
  liftIO . sendAll env.socket $ mkMessage zwlrLayerSurfaceV1ID 0 messageBody

  let sender = ("zwlr_layer_surface_v1", zwlrLayerSurfaceV1ID, "set_size")
  liftIO . strReq sender $ printf "width=%i height=%i" width height

zwlrLayerSurfaceV1_ackConfigure :: ObjectID 'ZwlrLayerSurfaceV1 -> Wayland ()
zwlrLayerSurfaceV1_ackConfigure zwlrLayerSurfaceV1ID = do
  env <- ask

  -- This can be any serial. You have to commit and acknowledge in order.
  serial <- atomically $ takeTMVar env.serial

  let messageBody = runPut $ do putWord32le serial
  liftIO . sendAll env.socket $ mkMessage zwlrLayerSurfaceV1ID 6 messageBody

  let sender = ("zwlr_layer_surface_v1", zwlrLayerSurfaceV1ID, "ack_configure")
  liftIO . strReq sender $ printf "serial=%i" serial

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
        putWord32le $ formatValue colorFormat
  liftIO . sendAll env.socket $ mkMessage wlShmPoolID 0 messageBody

  let sender = ("wl_shm_pool", wlShmPoolID, "create_buffer")
  liftIO . strReq sender $ printf "newID=%i" newObjectID
  modifyIORef env.objects (Map.insert newObjectID WlBuffer)
  return $ Buffer (coerce newObjectID) offset

wlRegistry_bind :: ObjectID 'WlRegistry -> WaylandInterface -> WlUint -> WlString -> WlUint -> Word32 -> Wayland (ObjectID a)
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
    $ printf
      "name=%i interface=\"%s\" version=%i id=%i"
      globalName
      (BSL.unpackChars interfaceName)
      interfaceVersion
      newObjectID

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

-- Event Handling {{{

parseEvent :: Map Word32 WaylandInterface -> Get WaylandEvent
parseEvent objects = do
  header <- get
  let bodySize = fromIntegral header.size - 8
  case (Map.lookup header.objectID objects, header.opCode) of
    (Just WlDisplay, 0) -> EvWlDisplay_error header <$> get
    (Just WlDisplay, 1) -> EvWlDisplay_deleteID header <$> get
    --
    (Just WlRegistry, 0) -> EvGlobal header <$> get
    (Just WlShm, 0) -> EvWlShm_format header <$> get
    (Just ZwlrLayerSurfaceV1, 0) -> EvWlrLayerSurface_configure header <$> get
    (Just WlBuffer, 0) -> pure $ EvBufferRelease header
    --
    (Just ExtWorkspaceManagerV1, 0) -> EvExtWorkspaceManagerV1_workspaceGroup header <$> get
    (Just ExtWorkspaceManagerV1, 1) -> EvExtWorkspaceManagerV1_workspace header <$> get
    (Just ExtWorkspaceManagerV1, 2) -> EvExtWorkspaceManagerV1_done header <$> get
    --
    (Just ExtWorkspaceHandleV1, 0) -> EvExtWorkspaceHandleV1_id header <$> get
    (Just ExtWorkspaceHandleV1, 1) -> EvExtWorkspaceHandleV1_name header <$> get
    (Just ExtWorkspaceHandleV1, 2) -> EvExtWorkspaceHandleV1_coordinates header <$> get
    (Just ExtWorkspaceHandleV1, 3) -> EvExtWorkspaceHandleV1_state header <$> get
    (Just ExtWorkspaceHandleV1, 4) -> EvExtWorkspaceHandleV1_capabilities header <$> get
    (Just ExtWorkspaceHandleV1, 5) -> EvExtWorkspaceHandleV1_removed header <$> get
    _ -> skip bodySize $> EvUnknown header

eventLoop :: Wayland ()
eventLoop = do
  env <- ask
  msg <- liftIO $ receiveSocketData env.socket
  unless (BSL.null msg) $ processBuffer (BS.toStrict msg)
  eventLoop

processBuffer :: BS.ByteString -> Wayland ()
processBuffer bytes = do
  env <- ask
  objects <- liftIO $ readIORef env.objects
  case pushChunk (runGetIncremental (parseEvent objects)) bytes of
    Done remaining _ event -> do
      liftIO $ case event of
        EvBufferRelease _ -> do pure ()
        _ -> displayEvent event
      handleEventResponse event
      unless (BS.null remaining)
        $ processBuffer remaining
    Partial _ ->
      return () -- incomplete message, wait for next socket read
    Fail _ _ err ->
      liftIO $ putStrLn $ "Parse error: " <> err

handleEventResponse :: WaylandEvent -> Wayland ()
handleEventResponse (EvBufferRelease _) = takeMVar =<< asks (.freeBuffer)
handleEventResponse (EvGlobal h ev) = do
  globals <- asks (.globals)
  modifyIORef globals $ Map.insert ev.name (h, ev)
handleEventResponse (EvWlrLayerSurface_configure _ ev) = do
  serial <- asks (.serial)
  atomically $ putTMVar serial ev.serial
handleEventResponse (EvExtWorkspaceManagerV1_workspace _ ev) = do
  objects <- asks (.objects)
  modifyIORef objects $ Map.insert ev.handleID ExtWorkspaceHandleV1
handleEventResponse _ = return ()

-- }}}

-- Events {{{
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
  | ExtWorkspaceManagerV1
  | ExtWorkspaceHandleV1
  deriving stock (Show)

type ID = Word32

data WaylandEvent
  = EvWlDisplay_error Header BodyWlDisplay_error
  | EvWlDisplay_deleteID Header BodyWlDisplay_deleteId
  | EvGlobal Header BodyGlobal
  | EvWlShm_format Header BodyWlShm_format
  | EvWlrLayerSurface_configure Header BodyWlrLayerSurface_configure
  | EvExtWorkspaceManagerV1_workspace Header BodyExtWorkspaceManagerV1_workspace
  | EvExtWorkspaceManagerV1_workspaceGroup Header BodyExtWorkspaceManagerV1_workspaceGroup
  | EvExtWorkspaceManagerV1_done Header BodyExtWorkspaceManagerV1_done
  | EvExtWorkspaceHandleV1_id Header BodyExtWorkspaceHandleV1_id
  | EvExtWorkspaceHandleV1_name Header BodyExtWorkspaceHandleV1_name
  | EvExtWorkspaceHandleV1_coordinates Header BodyExtWorkspaceHandleV1_coordinates
  | EvExtWorkspaceHandleV1_state Header BodyExtWorkspaceHandleV1_state
  | EvExtWorkspaceHandleV1_capabilities Header BodyExtWorkspaceHandleV1_capabilities
  | EvExtWorkspaceHandleV1_removed Header BodyExtWorkspaceHandleV1_removed
  | EvBufferRelease Header
  | EvUnknown Header

-- | Represents the Wayland color format.
data WlColorFormat
  = Argb8888
  | Xrgb8888
  deriving stock (Eq, Ord, Show, Enum, Bounded)

-- | Convert a format to its Wayland wire value.
formatValue :: WlColorFormat -> Word32
formatValue Argb8888 = 0
formatValue Xrgb8888 = 1

type Globals = Map Word32 (Header, BodyGlobal)

data BodyGlobal = BodyGlobal
  { name :: WlUint
  , interface :: WlString
  , version :: WlUint
  }
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyGlobal)

newtype BodyWlShm_format = BodyWlShm_format {format :: Word32}
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyWlShm_format)

data BodyWlDisplay_error = BodyWlDisplay_error
  { errorObjectID :: Word32
  , errorCode :: WlUint
  , errorMessage :: WlString
  }
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyWlDisplay_error)

newtype BodyWlDisplay_deleteId = BodyWlDisplay_deleteID {deletedID :: Word32}
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyWlDisplay_deleteId)

data BodyWlrLayerSurface_configure = BodyWlrLayerSurfaceConfigure
  { serial :: WlUint
  , width :: WlUint
  , height :: WlUint
  }
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyWlrLayerSurface_configure)

newtype BodyExtWorkspaceManagerV1_workspace = BodyExtWorkspaceManagerV1_workspace
  {handleID :: Word32}
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyExtWorkspaceManagerV1_workspace)

newtype BodyExtWorkspaceManagerV1_workspaceGroup = BodyExtWorkspaceManagerV1_workspaceGroup
  {handleID :: Word32}
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyExtWorkspaceManagerV1_workspaceGroup)

data BodyExtWorkspaceManagerV1_done = BodyExtWorkspaceManagerV1_done
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyExtWorkspaceManagerV1_done)

newtype BodyExtWorkspaceHandleV1_id = BodyExtWorkspaceHandleV1_id
  {id :: WlString}
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyExtWorkspaceHandleV1_id)

newtype BodyExtWorkspaceHandleV1_name = BodyExtWorkspaceHandleV1_name
  {name :: WlString}
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyExtWorkspaceHandleV1_name)

newtype BodyExtWorkspaceHandleV1_coordinates = BodyExtWorkspaceHandleV1_coordinates
  {coordinates :: WlArray Word32}
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyExtWorkspaceHandleV1_coordinates)

newtype BodyExtWorkspaceHandleV1_state = BodyExtWorkspaceHandleV1_state
  {state :: Word32}
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyExtWorkspaceHandleV1_state)

newtype BodyExtWorkspaceHandleV1_capabilities = BodyExtWorkspaceHandleV1_capabilities
  {capabilities :: Word32}
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyExtWorkspaceHandleV1_capabilities)

data BodyExtWorkspaceHandleV1_removed = BodyExtWorkspaceHandleV1_removed
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyExtWorkspaceHandleV1_removed)

formatEvent :: WaylandEvent -> String
formatEvent = \case
  EvWlDisplay_error h e -> printf "wl_display@%i.error: object_id=%i code=%i message=%s" h.objectID e.errorObjectID e.errorCode (BSL.unpackChars e.errorMessage)
  EvWlDisplay_deleteID h e -> printf "wl_display@%i.delete_id: id=%i" h.objectID e.deletedID
  EvGlobal h e -> printf "wl_registry@%i.global: name=%i interface=%s version=%i" h.objectID e.name (BSL.unpackChars e.interface) e.version
  EvWlShm_format h e -> printf "wl_shm@%i.format: format=%s (%i)" h.objectID (formatName e.format) e.format
  EvWlrLayerSurface_configure h e -> printf "zwlr_layer_surface_v1@%i.configure: serial=%i width=%i height=%i" h.objectID e.serial e.width e.height
  EvExtWorkspaceManagerV1_workspace h e -> printf "ext_workspace_manager_v1@%i.workspace: handle=%i" h.objectID e.handleID
  EvExtWorkspaceManagerV1_workspaceGroup h e -> printf "ext_workspace_manager_v1@%i.workspace_group handle=%i: " h.objectID e.handleID
  EvExtWorkspaceManagerV1_done h _ -> printf "ext_workspace_manager_v1@%i.done: done sending workspace info" h.objectID
  EvExtWorkspaceHandleV1_id h e -> printf "ext_workspace_handle_v1@%i.id: id=%s" h.objectID (BSL.unpackChars e.id)
  EvExtWorkspaceHandleV1_name h e -> printf "ext_workspace_handle_v1@%i.name: name=%s" h.objectID (BSL.unpackChars e.name)
  EvExtWorkspaceHandleV1_coordinates h e -> printf "ext_workspace_handle_v1@%i.coordinates: coordinates=%s" h.objectID (show @Text e.coordinates)
  EvExtWorkspaceHandleV1_state h e -> printf "ext_workspace_handle_v1@%i.state: state=%i" h.objectID e.state
  EvExtWorkspaceHandleV1_capabilities h e -> printf "ext_workspace_handle_v1@%i.capabilities: capabilities=%i" h.objectID e.capabilities
  EvExtWorkspaceHandleV1_removed h _ -> printf "ext_workspace_handle_v1@%i.removed: removed" h.objectID
  EvBufferRelease h -> printf "wl_buffer@%i.release: buffer released" h.objectID
  EvUnknown h -> printf "???: objectID=%i opCode=%i size=%i" h.objectID h.opCode h.size

displayEvent :: WaylandEvent -> IO ()
displayEvent ev = putStrLn $ "<- " <> formatEvent ev

-- Format names for wl_shm
formatName :: Word32 -> String
formatName 0 = "ARGB8888"
formatName 1 = "XRGB8888"
formatName n = "format_" <> show n

-- Generic little-endian Binary deriving
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

instance GBinaryLE (K1 i Int32) where
  ggetLE = K1 <$> getInt32le
  gputLE (K1 x) = putInt32le x

instance GBinaryLE (K1 i WlString) where
  ggetLE = K1 <$> getWlString
  gputLE (K1 x) = putWlString x

type role WlArray representational

newtype WlArray a = WlArray [a]
  deriving stock (Show)

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

-- Newtype wrapper for deriving via
type role LittleEndian representational

newtype LittleEndian a = LittleEndian a

instance (Generic a, GBinaryLE (Rep a)) => Binary (LittleEndian a) where
  get = LittleEndian . to <$> ggetLE
  put (LittleEndian x) = gputLE (from x)

--- }}}

-- Utils {{{

findInterface :: Globals -> BSL.ByteString -> Maybe BodyGlobal
findInterface globals targetInterface =
  let target = targetInterface <> "\0"
   in find (\(_, e) -> target `BSL.isPrefixOf` e.interface) globals >>= Just . snd

bindToInterface :: ObjectID 'WlRegistry -> IORef Globals -> WlString -> WaylandInterface -> Wayland (ObjectID a)
bindToInterface registryID globalsRef targetInterface waylandInterface =
  let go (count :: Int) = do
        when
          (count >= 10)
          (putStrLn ("ERROR: the wayland global " <> BSL.unpackChars targetInterface <> " not found") >> exitFailure)
        liftIO $ printf "Trying to bind to %s... (%i)\n" (BSL.unpackChars targetInterface) count
        env <- ask
        globals <- readIORef globalsRef
        case findInterface globals targetInterface of
          Nothing -> liftIO (threadDelay 100000) >> go (count + 1)
          Just e -> do
            newObjectID <- liftIO $ nextID env.counter
            wlRegistry_bind registryID waylandInterface e.name targetInterface e.version newObjectID
   in go 1

padLen :: Word32 -> Int64
padLen l = (.&.) (fromIntegral l + 3) (-4)

putWlString :: WlString -> Put
putWlString bs = do
  let str = bs <> "\0"
  putWord32le (fromIntegral $ BSL.length str)
  putLazyByteString str
  let paddingBytes = padLen (fromIntegral $ BSL.length str) - BSL.length str
  replicateM_ (fromIntegral paddingBytes) (putWord8 0)

getWlString :: Get WlString
getWlString = do
  len <- getWord32le
  str <- getLazyByteString (fromIntegral len)
  skip $ fromIntegral (padLen len - fromIntegral len)
  return str

headerSize :: Int64
headerSize = 8 -- The header size is always 8 in Wayland

waylandNull :: Word32
waylandNull = 0 -- Nulls are just 0 in Wayland

wlColorFormatArgb8888 :: WlInt
wlColorFormatArgb8888 = 0

wlColorFormatXrgb8888 :: WlInt
wlColorFormatXrgb8888 = 1

wlDisplayID :: ObjectID 'WlDisplay
wlDisplayID = 1 -- wlDisplay always has ID 1 in Wayland

getColorize :: (IsString s, Semigroup s) => IO (ColorIntensity -> Color -> s -> s)
getColorize = do
  ansiSupport <- hNowSupportsANSI stdout
  pure
    $ if ansiSupport
      then \ci c t -> fromString (setSGRCode [SetColor Foreground ci c]) <> t <> fromString (setSGRCode [Reset])
      else const $ const id

strReq :: (String, ObjectID a, String) -> String -> IO ()
strReq (object, objectID, method) text = do
  colorize <- getColorize
  putStrLn . colorize Vivid Magenta $ printf ("        -> %s@%i.%s: " <> text) object objectID method

strReq2 :: (String, ObjectID a, String) -> String -> IO ()
strReq2 (object, objectID, method) text = do
  colorize <- getColorize
  putStrLn . colorize Vivid Magenta $ mconcat ["        -> ", object, "@", show objectID, ".", method, ": ", text]

mkMessage :: ObjectID a -> Word16 -> BSL.ByteString -> BSL.ByteString
mkMessage objectID opCode messageBody =
  runPut $ do
    putWord32le $ coerce objectID
    putWord16le opCode
    putWord16le $ fromIntegral (headerSize + BSL.length messageBody)
    putLazyByteString messageBody

wlDisplayConnect :: IO Socket
wlDisplayConnect = do
  xdg_runtime_dir <- getEnv "XDG_RUNTIME_DIR"
  wayland_display <- getEnv "WAYLAND_DISPLAY"
  let path = xdg_runtime_dir <> "/" <> wayland_display
  sock <- socket AF_UNIX Stream defaultProtocol
  connect sock (SockAddrUnix path)
  return sock

receiveSocketData :: Socket -> IO BSL.ByteString
receiveSocketData sock = do
  liftIO $ recv sock 4096

nextID' :: IORef Word32 -> IO Word32
nextID' counter = do
  current <- readIORef counter
  modifyIORef counter (+ 1)
  return current

nextID :: (MonadIO m) => IORef Word32 -> m Word32
nextID = liftIO . nextID'

-- }}}

-- vim: foldmethod=marker
