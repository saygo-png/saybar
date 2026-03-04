{- HLINT ignore "Use camelCase" -}

module Main (main) where

import Codec.Picture (PixelRGBA8 (..))
import Codec.Picture.Types (Image)
import Config
import Control.Concurrent (forkIO, threadDelay)
import Control.Exception
import Data.Binary
import Data.ByteString.Lazy hiding (count)
import GHC.IO.Handle
import Graphics.Text.TrueType (loadFontFile)
import Network.Socket
import Relude hiding (ByteString, get, isPrefixOf, put)
import Saywayland
import Saywayland.Internal.Utils
import System.Posix (ownerReadMode, ownerWriteMode, setFdSize, unionFileModes)
import System.Posix.IO
import System.Posix.SharedMem
import Bar

main :: IO ()
main = do
  runReaderT program =<< waylandSetup

waylandSetup :: IO WaylandEnv
waylandSetup = do
  sock <- wlDisplayConnect
  counter <- newIORef 2 -- start from 2 because wl_display is always 1
  globals <- newIORef mempty
  objects <- newIORef mempty
  serial <- newEmptyTMVarIO
  let freeBuffer :: IO (MVar ()) = newEmptyMVar

  WaylandEnv sock counter globals objects serial <$> freeBuffer

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

  putStrLn "Binding to required interfaces..."
  wlShmID <- bindToInterface registryID env.globals "wl_shm" WlShm
  wlCompositorID <- bindToInterface registryID env.globals "wl_compositor" WlCompositor
  zwlrLayerShellV1ID <- bindToInterface registryID env.globals "zwlr_layer_shell_v1" ZwlrLayerShellV1

  wlSurfaceID <- wlCompositor_createSurface wlCompositorID
  layerSurfaceID <- zwlrLayerShellV1_getLayerSurface zwlrLayerShellV1ID wlSurfaceID 2 "saybar"
  zwlrLayerSurfaceV1_setAnchor layerSurfaceID 13 -- top left right anchors
  zwlrLayerSurfaceV1_setSize layerSurfaceID 0 bufferHeight
  zwlrLayerSurfaceV1_setExclusiveZone layerSurfaceID (fromIntegral bufferHeight)
  wlSurface_commit wlSurfaceID
  zwlrLayerSurfaceV1_ackConfigure layerSurfaceID

  font <- either (error . toText) pure =<< liftIO (loadFontFile "CourierPrime-Regular.ttf")

  let makeSharedMemoryObject = shmOpen poolName (ShmOpenFlags True True False True) (Relude.foldl' unionFileModes ownerWriteMode [ownerReadMode])
      removeSharedMemoryObject _ = shmUnlink poolName
      useSharedMemoryObject fileDescriptor =
        flip runReaderT env $ do
          let frameSize = bufferWidth * bufferHeight * colorChannels
          let poolSize = 2 * frameSize -- 2x for double buffering
          liftIO . setFdSize fileDescriptor $ fromIntegral poolSize
          wlShmPoolID <- wlShm_createPool wlShmID poolSize fileDescriptor
          bufferA <- wlShmPool_createBuffer wlShmPoolID 0 bufferWidth bufferHeight colorChannels colorFormat
          bufferB <- wlShmPool_createBuffer wlShmPoolID frameSize bufferWidth bufferHeight colorChannels colorFormat

          fileHandle <- liftIO $ fdToHandle fileDescriptor

          let renderLoop = do
                img <- renderBarState font <$> liftIO getBarState
                putImage wlSurfaceID fileHandle img bufferA

                img2 <- renderBarState font <$> liftIO getBarState
                putImage wlSurfaceID fileHandle img2 bufferB
                renderLoop
          renderLoop

  liftIO . void $ bracket makeSharedMemoryObject removeSharedMemoryObject useSharedMemoryObject

putImage :: Word32 -> Handle -> Image PixelRGBA8 -> Buffer -> Wayland ()
putImage wlSurfaceID fileHandle image buffer = do
  freeBuffer <- asks (.freeBuffer)
  liftIO . hSeek fileHandle AbsoluteSeek $ fromIntegral buffer.offset
  liftIO . hPut fileHandle $ swizzleRGBAtoBGRA image
  wlSurface_damageBuffer wlSurfaceID 0 0 bufferWidth bufferHeight
  wlSurface_attach wlSurfaceID buffer.id
  wlSurface_commit wlSurfaceID
  liftIO $ threadDelay 100000
  putMVar freeBuffer ()
