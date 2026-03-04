module Bar (swizzleRGBAtoBGRA, getBarState, renderBarState) where

import Codec.Picture (PixelRGBA8 (..), imageData)
import Codec.Picture.Types (Image)
import Config
import Data.Binary
import Data.ByteString.Lazy hiding (count)
import Data.ByteString.Lazy qualified as BSL
import Data.Vector.Storable qualified as VS
import Graphics.Rasterific
import Graphics.Rasterific.Texture
import Graphics.Text.TrueType (Font)
import Relude hiding (ByteString, get, isPrefixOf, put)
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
