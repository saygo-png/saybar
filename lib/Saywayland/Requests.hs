module Saywayland.Requests (wlDisplay_getRegistry, wlShm_createPool, wlSurface_attach, zwlrLayerShellV1_getLayerSurface, zwlrLayerSurfaceV1_setAnchor, zwlrLayerSurfaceV1_setSize, zwlrLayerSurfaceV1_ackConfigure, zwlrLayerSurfaceV1_setExclusiveZone, wlShmPool_createBuffer, wlRegistry_bind, wlCompositor_createSurface, wlSurface_commit, wlSurface_damageBuffer) where

import Data.Binary
import Data.Binary.Put
import Data.ByteString qualified as BS
import Data.ByteString.Lazy
import Data.ByteString.Lazy.Internal qualified as BSL
import Data.Map qualified as Map
import Network.Socket.ByteString (sendManyWithFds)
import Network.Socket.ByteString.Lazy
import Relude hiding (ByteString, get, isPrefixOf, length, put, replicate)
import Saywayland.Internal.Utils
import Saywayland.Types
import System.Posix.Types
import Text.Printf

{- HLINT ignore "Use camelCase" -}

wlDisplay_getRegistry :: Wayland Word32
wlDisplay_getRegistry = do
  env <- ask
  registryID <- nextID env.counter
  -- The object here is actually saved before the request is sent
  -- This is because the registry id is needed for parsing its requests/events
  modifyIORef env.objects (Map.insert registryID WlRegistry)
  let messageBody = runPut $ putWord32le registryID
  liftIO . sendAll env.socket $ mkMessage wlDisplayID 1 messageBody
  liftIO . strReq ("wl_display", wlDisplayID, "get_registry") $ printf "wl_registry=%i" registryID
  return registryID

wlShm_createPool :: Word32 -> Word32 -> Fd -> Wayland Word32
wlShm_createPool wlShmID poolSize fileDescriptor = do
  env <- ask
  newObjectID <- nextID env.counter
  let messageBody = runPut $ do
        putWord32le newObjectID
        putWord32le poolSize
  let msg = BS.toStrict $ mkMessage wlShmID 0 messageBody
  liftIO $ sendManyWithFds env.socket [msg] [fileDescriptor]

  let sender = ("wl_shm", wlShmID, "create_pool")
  liftIO . strReq sender $ printf "newID=%i fd=%s size=%i" newObjectID (show @Text fileDescriptor) poolSize
  modifyIORef env.objects (Map.insert newObjectID WlShmPool)
  return newObjectID

wlSurface_attach :: Word32 -> Word32 -> Wayland ()
wlSurface_attach wlSurfaceID wlBufferID = do
  env <- ask
  let messageBody = runPut $ do
        putWord32le wlBufferID
        -- x y arguments have to be set to 0
        putInt32le 0
        putInt32le 0
  liftIO . sendAll env.socket $ mkMessage wlSurfaceID 1 messageBody

  let sender = ("wl_surface", wlSurfaceID, "attach")
  liftIO . strReq sender $ printf "bufferId=%i x=%i y=%i" wlBufferID (0 :: Int32) (0 :: Int32)

wlSurface_damageBuffer :: Word32 -> Int32 -> Int32 -> Word32 -> Word32 -> Wayland ()
wlSurface_damageBuffer wlSurfaceID x y width height = do
  env <- ask
  let messageBody = runPut $ do
        putInt32le x
        putInt32le y
        putWord32le width
        putWord32le height
  liftIO . sendAll env.socket $ mkMessage wlSurfaceID 9 messageBody

  let sender = ("wl_surface", wlSurfaceID, "damage_buffer")
  liftIO . strReq sender $ printf "x=%i y=%i width=%i height=%i" x y width height

zwlrLayerShellV1_getLayerSurface :: Word32 -> Word32 -> Word32 -> ByteString -> Wayland Word32
zwlrLayerShellV1_getLayerSurface zwlrLayerShellV1ID wlSurfaceID layer namespace = do
  env <- ask
  newObjectID <- nextID env.counter
  let messageBody = runPut $ do
        putWord32le newObjectID
        putWord32le wlSurfaceID
        putWord32le waylandNull
        putWord32le layer
        putWlString namespace
  liftIO . sendAll env.socket $ mkMessage zwlrLayerShellV1ID 0 messageBody

  let sender = ("zwlr_layer_shell_v1", zwlrLayerShellV1ID, "get_layer_surface")
  liftIO
    . strReq sender
    $ printf "newID=%i wl_surface=%i output=%i layer=%i namespace=%s" newObjectID wlSurfaceID waylandNull layer (BSL.unpackChars namespace)

  modifyIORef env.objects (Map.insert newObjectID ZwlrLayerSurfaceV1)
  return newObjectID

zwlrLayerSurfaceV1_setAnchor :: Word32 -> Word32 -> Wayland ()
zwlrLayerSurfaceV1_setAnchor zwlrLayerSurfaceV1ID anchor = do
  env <- ask

  let messageBody = runPut $ putWord32le anchor
  liftIO $ sendAll env.socket $ mkMessage zwlrLayerSurfaceV1ID 1 messageBody

  let sender = ("zwlr_layer_surface_v1", zwlrLayerSurfaceV1ID, "set_anchor")
  liftIO . strReq sender $ printf "anchor=%i" anchor

zwlrLayerSurfaceV1_setSize :: Word32 -> Word32 -> Word32 -> Wayland ()
zwlrLayerSurfaceV1_setSize zwlrLayerSurfaceV1ID width height = do
  env <- ask

  let messageBody = runPut $ do
        putWord32le width
        putWord32le height
  liftIO . sendAll env.socket $ mkMessage zwlrLayerSurfaceV1ID 0 messageBody

  let sender = ("zwlr_layer_surface_v1", zwlrLayerSurfaceV1ID, "set_size")
  liftIO . strReq sender $ printf "width=%i height=%i" width height

zwlrLayerSurfaceV1_ackConfigure :: Word32 -> Wayland ()
zwlrLayerSurfaceV1_ackConfigure zwlrLayerSurfaceV1ID = do
  env <- ask

  -- This can be any serial. You have to commit and acknowledge in order.
  serial <- atomically $ takeTMVar env.serial

  let messageBody = runPut $ do putWord32le serial
  liftIO . sendAll env.socket $ mkMessage zwlrLayerSurfaceV1ID 6 messageBody

  let sender = ("zwlr_layer_surface_v1", zwlrLayerSurfaceV1ID, "ack_configure")
  liftIO . strReq sender $ printf "serial=%i" serial

zwlrLayerSurfaceV1_setExclusiveZone :: Word32 -> Int32 -> Wayland ()
zwlrLayerSurfaceV1_setExclusiveZone zwlrLayerSurfaceV1ID zone = do
  env <- ask

  let messageBody = runPut $ do putInt32le zone
  liftIO $ sendAll env.socket $ mkMessage zwlrLayerSurfaceV1ID 2 messageBody

  let sender = ("zwlr_layer_surface_v1", zwlrLayerSurfaceV1ID, "set_exclusive_zone")
  liftIO . strReq sender $ printf "zone=%i" zone

wlShmPool_createBuffer :: Word32 -> Word32 -> Word32 -> Word32 -> Word32 -> Word32 -> Wayland Buffer
wlShmPool_createBuffer wlShmPoolID offset bufferWidth bufferHeight colorChannels colorFormat = do
  env <- ask
  newObjectID <- nextID env.counter

  let messageBody = runPut $ do
        putWord32le newObjectID
        putWord32le offset
        putWord32le bufferWidth
        putWord32le bufferHeight
        putWord32le $ bufferWidth * colorChannels -- Stride
        putWord32le colorFormat
  liftIO . sendAll env.socket $ mkMessage wlShmPoolID 0 messageBody

  let sender = ("wl_shm_pool", wlShmPoolID, "create_buffer")
  liftIO . strReq sender $ printf "newID=%i" newObjectID
  modifyIORef env.objects (Map.insert newObjectID WlBuffer)
  return $ Buffer newObjectID offset

wlRegistry_bind :: Word32 -> WaylandInterface -> Word32 -> ByteString -> Word32 -> Word32 -> Wayland Word32
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
  return newObjectID

wlCompositor_createSurface :: Word32 -> Wayland Word32
wlCompositor_createSurface wlCompositorID = do
  env <- ask
  newObjectID <- nextID env.counter

  let messageBody = runPut $ putWord32le newObjectID
  liftIO $ sendAll env.socket $ mkMessage wlCompositorID 0 messageBody

  let sender = ("wl_compositor", wlCompositorID, "create_surface")
  liftIO . strReq sender $ printf "newID=%i" newObjectID
  modifyIORef env.objects (Map.insert newObjectID WlSurface)
  return newObjectID

wlSurface_commit :: Word32 -> Wayland ()
wlSurface_commit wlSurfaceID = do
  env <- ask

  let messageBody = runPut mempty
  liftIO . sendAll env.socket $ mkMessage wlSurfaceID 6 messageBody

  let sender = ("wl_surface", wlSurfaceID, "commit")
  liftIO $ strReq sender "commit request"
