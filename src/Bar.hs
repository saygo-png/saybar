module Bar (swizzleRGBAtoBGRA, getBarState, renderBarState, workspaceEventsHandler) where

import Codec.Picture (PixelRGBA8 (..), imageData)
import Codec.Picture.Types (Image)
import Config
import Data.Binary
import Data.Bits
import Data.ByteString.Lazy qualified as BSL
import Data.Map qualified as Map
import Data.Text qualified as T
import Data.Vector.Storable qualified as VS
import Graphics.Rasterific
import Graphics.Rasterific.Texture
import Graphics.Text.TrueType (Font)
import Relude hiding (ByteString, get, isPrefixOf, put)
import Saywayland
import System.Process.Typed
import Types

swizzleRGBAtoBGRA :: Image PixelRGBA8 -> BSL.ByteString
swizzleRGBAtoBGRA image =
  BSL.pack . go . VS.toList $ imageData image
  where
    go [] = []
    go (r : g : b : a : rest) =
      let premul c = fromIntegral (fromIntegral c * fromIntegral a `div` 255 :: Word16)
       in premul b : premul g : premul r : a : go rest
    go _ = []

workspaceEventsHandler :: WorkspaceMap -> WaylandEvent -> WorkspaceMap
workspaceEventsHandler workspaces = \case
  EvExtWorkspaceHandleV1_name h e ->
    Map.alter
      ( \case
          Nothing -> pure $ WorkspaceInfo (wlToText e.name) Inactive
          Just w -> pure w{wsName = wlToText e.name}
      )
      h.objectID
      workspaces
  EvExtWorkspaceHandleV1_state h e ->
    Map.adjust (\w -> w{wsState = decodeState e.state}) h.objectID workspaces
    where
      -- https://wayland.app/protocols/ext-workspace-v1#ext_workspace_handle_v1:enum:state
      decodeState s
        | s .&. 2 /= 0 = Urgent
        | s .&. 1 /= 0 = Active
        | s .&. 4 /= 0 = Hidden
        | otherwise = Inactive
  EvExtWorkspaceHandleV1_removed h _ ->
    Map.delete h.objectID workspaces
  _ -> workspaces

getBarState :: IORef WorkspaceMap -> IO BarState
getBarState mapRef = do
  workspaces <- Map.elems <$> readIORef mapRef
  date <- getDate
  print $ BarState date workspaces
  pure $ BarState date workspaces
  where
    getDate :: IO Text
    getDate = do
      (dateOut, _dateErr) <- readProcess_ "date"
      pure . decodeUtf8 . BSL.reverse . BSL.drop 1 $ BSL.reverse dateOut

renderBarState :: Font -> BarState -> Image PixelRGBA8
renderBarState font barState = do
  let bgColor = PixelRGBA8 0 0 0 0
      drawColor = PixelRGBA8 213 196 161 255 -- #d5c4a1
      workspaceNames =
        T.intercalate " "
          $ map
            ( \w -> case w.wsState of
                Active -> "[" <> w.wsName <> "]"
                Hidden -> mempty
                _ -> w.wsName
            )
            barState.workspaces

  renderDrawing (fromIntegral bufferWidth) (fromIntegral bufferHeight) bgColor $ do
    withTexture (uniformTexture drawColor) $ do
      let text = mconcat [barState.date, " | ", workspaceNames]
      printTextAt font (PointSize 11) (V2 20 15) $ toString text
