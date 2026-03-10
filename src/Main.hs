{- HLINT ignore "Use camelCase" -}

module Main (main) where

import Bar
import Codec.Picture (PixelRGBA8 (..))
import Codec.Picture.Types (Image)
import Config
import Control.Concurrent (forkIO, threadDelay)
import Control.Concurrent.STM (check)
import Control.Exception
import Data.ByteString.Lazy hiding (count)
import GHC.Conc (orElse)
import GHC.IO.Handle
import Graphics.Text.TrueType (loadFontFile)
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

waylandSetup :: IO WaylandEnv
waylandSetup = do
  sock <- connectToWlSocket
  counter <- newIORef 2 -- start from 2 because wl_display is always 1
  globals <- newIORef mempty
  objects <- newIORef mempty
  handlers <- newIORef mempty

  pure $ WaylandEnv sock counter globals objects handlers

program :: Wayland ()
program = do
  env <- ask

  liftIO
    . void
    . forkIO
    $ finally
      (putStrLn "\n--- Starting event loop ---" >> runReaderT eventLoop env)
      (close env.socket)

  registryID <- wlDisplay_getRegistry
  -- `pendingRef` accumulates event-by-event within a batch.
  -- `committedRef` is only updated on `done` and is what gets rendered.
  -- This means the render loop always sees a consistent snapshot.
  pendingRef :: IORef WorkspaceMap <- newIORef mempty
  committedRef :: IORef WorkspaceMap <- newIORef mempty
  timerFired :: TVar Bool <- newTVarIO False
  serial :: TMVar WlUint <- newEmptyTMVarIO
  freeBuffer :: MVar () <- newEmptyMVar
  dirty :: TMVar () <- newEmptyTMVarIO
  previousState :: IORef BarState <- newIORef $ BarState mempty mempty

  putStrLn "Binding to required interfaces..."
  wlShmID <- bindToInterface registryID env.globals "wl_shm" WlShm
  wlCompositorID <- bindToInterface registryID env.globals "wl_compositor" WlCompositor
  zwlrLayerShellV1ID <- bindToInterface registryID env.globals "zwlr_layer_shell_v1" ZwlrLayerShellV1
  _extWorkspaceManagerV1ID <- bindToInterface registryID env.globals "ext_workspace_manager_v1" ExtWorkspaceManagerV1
  onEvent $ \ev -> liftIO $ case ev of
    EvExtWorkspaceManagerV1_done _ _ -> do
      -- Batch complete: promote pending to committed.
      readIORef pendingRef >>= writeIORef committedRef
      atomically $ void $ tryPutTMVar dirty ()
    _ ->
      modifyIORef pendingRef (`workspaceEventsHandler` ev)

  onEvent $ \case
    (EvZwlrLayerSurfaceV1_configure _ body) -> do
      atomically $ putTMVar serial body.serial
    (EvWlBuffer_release _ _) -> do
      takeMVar freeBuffer
    _ -> pure ()

  wlSurfaceID <- wlCompositor_createSurface wlCompositorID
  layerSurfaceID <- zwlrLayerShellV1_getLayerSurface zwlrLayerShellV1ID wlSurfaceID 2 "saybar"
  zwlrLayerSurfaceV1_setAnchor layerSurfaceID 13 -- top left right anchors
  zwlrLayerSurfaceV1_setSize layerSurfaceID 0 $ fromIntegral bufferHeight
  zwlrLayerSurfaceV1_setExclusiveZone layerSurfaceID bufferHeight
  wlSurface_commit wlSurfaceID
  zwlrLayerSurfaceV1_ackConfigure layerSurfaceID =<< atomically (takeTMVar serial)

  font <- either (error . toText) pure =<< liftIO (loadFontFile "CourierPrime-Regular.ttf")

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

          let waitForUpdate =
                atomically
                  $
                  -- Wake on workspace change...
                  takeTMVar dirty
                  -- ...or when the timer fires
                  `orElse` (readTVar timerFired >>= check)

          -- Cycle through buffers only when we actually render.
          -- If state is unchanged we loop back with the same buffer,
          -- so we never write to a buffer that's still in use.
          let renderLoop (buf : rest) = do
                waitForUpdate
                atomically $ writeTVar timerFired False
                mBarState <- liftIO $ getBarState committedRef previousState
                case mBarState of
                  Nothing -> renderLoop (buf : rest) -- unchanged, skip render
                  Just barState -> do
                    putImage wlSurfaceID fileHandle (renderBarState font barState) buf freeBuffer
                    putTextLn "rerender!!!"
                    renderLoop (rest ++ [buf])
              renderLoop [] = error "empty buffer list" -- unreachable
          liftIO . void . forkIO . forever $ do
            threadDelay (60000 * 1000)
            atomically $ writeTVar timerFired True

          renderLoop [bufferA, bufferB]

  liftIO . void $ bracket makeSharedMemoryObject removeSharedMemoryObject useSharedMemoryObject

putImage :: ObjectID 'WlSurface -> Handle -> Image PixelRGBA8 -> Buffer -> MVar () -> Wayland ()
putImage wlSurfaceID fileHandle image buffer freeBuffer = do
  liftIO . hSeek fileHandle AbsoluteSeek $ fromIntegral buffer.offset
  liftIO . hPut fileHandle $ swizzleRGBAtoBGRA image
  wlSurface_damageBuffer wlSurfaceID 0 0 bufferWidth bufferHeight
  wlSurface_attach wlSurfaceID buffer.id
  wlSurface_commit wlSurfaceID
  liftIO $ threadDelay 100000
  putMVar freeBuffer ()
