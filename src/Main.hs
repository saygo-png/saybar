{- HLINT ignore "Use camelCase" -}

module Main (main) where

import Codec.Picture (PixelRGBA8 (..), imageData)
import Codec.Picture.Types (Image)
import Config
import Control.Concurrent (forkIO, threadDelay)
import Control.Exception
import Data.Binary
import Data.ByteString.Lazy hiding (count)
import Data.ByteString.Lazy qualified as BSL
import Data.Vector.Storable qualified as VS
import GHC.IO.Handle
import Graphics.Rasterific
import Graphics.Rasterific.Texture
import Graphics.Text.TrueType (Font, loadFontFile)
import Network.Socket
import Relude hiding (ByteString, get, isPrefixOf, put)
import Saywayland
import Saywayland.Internal.Utils
import System.Posix (ownerReadMode, ownerWriteMode, setFdSize, unionFileModes)
import System.Posix.IO
import System.Posix.SharedMem
import System.Process.Typed
import Types

swizzleRGBAtoBGRA :: Image PixelRGBA8 -> ByteString
swizzleRGBAtoBGRA image =
  pack . go . VS.toList $ imageData image
  where
    go [] = []
    go (r : g : b : a : rest) =
      let premul c = fromIntegral (fromIntegral c * fromIntegral a `div` 255 :: Word16)
       in premul b : premul g : premul r : a : go rest
    go _ = []

getBarState :: IO BarState
getBarState = do
  (dateOut, _dateErr) <- readProcess_ "date"
  let dateFinal = BSL.reverse . BSL.drop 1 $ BSL.reverse dateOut
  pure . BarState $ decodeUtf8 dateFinal

renderBarState :: Font -> BarState -> Image PixelRGBA8
renderBarState font barState = do
  let bgColor = PixelRGBA8 0 0 0 0
      drawColor = PixelRGBA8 213 196 161 255 -- #d5c4a1
  renderDrawing (fromIntegral bufferWidth) (fromIntegral bufferHeight) bgColor $ do
    withTexture (uniformTexture drawColor) $ do
      printTextAt font (PointSize 11) (V2 20 15) $ toString barState.date

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

  WaylandEnv sock counter globals objects serial <$> newEmptyMVar

program :: Wayland ()
program = do
  env <- ask

  liftIO
    . void
    . forkIO
    $ finally
      (putStrLn "\n--- Starting event loop ---" >> runReaderT eventLoop env)
      (close env.socket)

  liftIO $ threadDelay 10000
  registryID <- wlDisplay_getRegistry

  wlShmID <- bindToInterface registryID env.globals "wl_shm" WlShm
  wlCompositorID <- bindToInterface registryID env.globals "wl_compositor" WlCompositor
  zwlrLayerShellV1ID <- bindToInterface registryID env.globals "zwlr_layer_shell_v1" ZwlrLayerShellV1

  wlSurfaceID <- wlCompositor_createSurface wlCompositorID
  --
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
