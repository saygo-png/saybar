{- HLINT ignore "Use camelCase" -}

module Main (main) where

import Bar
import Codec.Picture (PixelRGBA8 (..))
import Codec.Picture.Types (Image)
import Config
import Control.Concurrent (forkIO, threadDelay)
import Control.Exception
import Data.Map qualified as Map
import GHC.IO.Handle
import Graphics.Text.TrueType (PointSize (PointSize), loadFontFile)
import Modules
import Network.Socket
import Relude hiding (ByteString, get, isPrefixOf, put)
import Saywayland
import System.Posix (ownerReadMode, ownerWriteMode, setFdSize, unionFileModes)
import System.Posix.IO
import System.Posix.SharedMem
import Types

main :: IO ()
main = do
  runReaderT program =<< waylandSetup
  where
    waylandSetup :: IO WaylandEnv
    waylandSetup = do
      sock <- connectToWlSocket
      counter <- newIORef $ coerce wlDisplayID + 1
      globals <- newIORef mempty
      objects <- newIORef mempty
      handlers <- newIORef mempty
      pure $ WaylandEnv sock counter globals objects handlers

program :: Wayland ()
program = do
  env <- ask
  startEventLoop env

  registryID <- wlDisplay_getRegistry

  -- `pendingRef` accumulates event-by-event within a batch.
  -- `committed` is only updated on `done` and is what gets rendered.
  -- This means the render loop always sees a consistent snapshot (is atomic).
  pendingRef :: IORef WorkspaceMap <- newIORef mempty
  committed :: TVar WorkspaceMap <- newTVarIO mempty
  workspacesVar :: TVar [Workspace] <- newTVarIO mempty -- live workspace list
  wakeUp :: TMVar () <- newEmptyTMVarIO
  serial :: TMVar WlUint <- newEmptyTMVarIO
  freeBuffer :: MVar () <- newEmptyMVar

  putStrLn "Binding to required interfaces..."
  wlShmID <- bindToInterface registryID env.globals "wl_shm" WlShm
  wlCompositorID <- bindToInterface registryID env.globals "wl_compositor" WlCompositor
  zwlrLayerShellV1ID <- bindToInterface registryID env.globals "zwlr_layer_shell_v1" ZwlrLayerShellV1
  _extWorkspaceManagerV1ID <- bindToInterface registryID env.globals "ext_workspace_manager_v1" ExtWorkspaceManagerV1

  onEvent $ \case
    EvExtWorkspaceManagerV1_done _ _ -> do
      pending <- readIORef pendingRef
      let resolved = resolveWorkspaces pending
      atomically $ do
        writeTVar committed pending
        forM_ resolved $ writeTVar workspacesVar
        void $ tryPutTMVar wakeUp ()
    ev -> modifyIORef pendingRef (`workspaceEventsHandler` ev)

  onEvent $ \case
    (EvZwlrLayerSurfaceV1_configure _ body) ->
      atomically $ putTMVar serial body.serial
    (EvWlBuffer_release _ _) ->
      takeMVar freeBuffer
    _ -> pure ()

  let modules = makeModules workspacesVar
  startModules (rights modules) wakeUp

  wlSurfaceID <- wlCompositor_createSurface wlCompositorID
  layerSurfaceID <- zwlrLayerShellV1_getLayerSurface zwlrLayerShellV1ID wlSurfaceID 2 "saybar"
  zwlrLayerSurfaceV1_setAnchor layerSurfaceID 13 -- top left right anchors
  zwlrLayerSurfaceV1_setSize layerSurfaceID 0 $ fromIntegral bufferHeight
  zwlrLayerSurfaceV1_setExclusiveZone layerSurfaceID bufferHeight
  wlSurface_commit wlSurfaceID
  zwlrLayerSurfaceV1_ackConfigure layerSurfaceID =<< atomically (takeTMVar serial)

  font <- either (error . toText) pure =<< liftIO (loadFontFile "CourierPrime-Regular.ttf")

  let ctx =
        RenderCtx
          { font = font
          , fontSize = PointSize 11
          , dpi = 96
          , drawColor = PixelRGBA8 213 196 161 255 -- #d5c4a1
          }

  let makeSharedMemoryObject = shmOpen poolName (ShmOpenFlags True True False True) (Relude.foldl' unionFileModes ownerWriteMode [ownerReadMode])
      removeSharedMemoryObject _ = shmUnlink poolName
      useSharedMemoryObject fileDescriptor =
        flip runReaderT env $ do
          let frameSize = bufferWidth * bufferHeight * colorChannels
          let poolSize = 2 * frameSize -- 2x for double buffering
          liftIO . setFdSize fileDescriptor $ fromIntegral poolSize
          wlShmPoolID <- wlShm_createPool wlShmID fileDescriptor poolSize
          bufferA <- wlShmPool_createBuffer wlShmPoolID 0 bufferWidth bufferHeight colorChannels Argb8888
          bufferB <- wlShmPool_createBuffer wlShmPoolID frameSize bufferWidth bufferHeight colorChannels Argb8888

          fileHandle <- liftIO $ fdToHandle fileDescriptor

          let renderLoop :: (Buffer, Buffer) -> Wayland ()
              renderLoop buffers = do
                atomically $ takeTMVar wakeUp
                image <- liftIO $ renderBar ctx modules
                putImage wlSurfaceID fileHandle image (fst buffers) freeBuffer
                putTextLn $ "rerender!!!"
                renderLoop (swap buffers)

          renderLoop (bufferA, bufferB)

  liftIO . void $ bracket makeSharedMemoryObject removeSharedMemoryObject useSharedMemoryObject
  where
    startEventLoop env = do
      liftIO
        . void
        . forkIO
        $ finally
          (putStrLn "\n--- Starting event loop ---" >> runReaderT eventLoop env)
          (close env.socket)

    putImage :: ObjectID 'WlSurface -> Handle -> Image PixelRGBA8 -> Buffer -> MVar () -> Wayland ()
    putImage wlSurfaceID fileHandle image buffer freeBuffer = do
      liftIO . hSeek fileHandle AbsoluteSeek $ fromIntegral buffer.offset
      liftIO $ writeSwizzledRGBAtoBGRA fileHandle image
      wlSurface_damageBuffer wlSurfaceID 0 0 bufferWidth bufferHeight
      wlSurface_attach wlSurfaceID buffer.id
      wlSurface_commit wlSurfaceID
      liftIO $ threadDelay 100000
      putMVar freeBuffer ()

    -- \| Promote a WorkspaceMap to a clean sorted [Workspace].
    --   Returns Nothing if any workspace is still missing fields.
    resolveWorkspaces :: WorkspaceMap -> Maybe [Workspace]
    resolveWorkspaces m =
      sortOn (.wsCoordinates) <$> traverse promote (Map.elems m)
      where
        promote (PendingWorkspace (Just n) (Just c) (Just s)) = Just (Workspace n c s)
        promote _ = Nothing
