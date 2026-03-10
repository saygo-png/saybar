module Bar (swizzleRGBAtoBGRA, getBarState, renderBarState, workspaceEventsHandler) where

import Codec.Picture (PixelRGBA8 (..), imageData)
import Codec.Picture.Types (Image)
import Config
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
          Nothing -> pure $ PendingWorkspace (Just $ wlToText e.name) Nothing Nothing
          Just w -> pure w{pwName = Just $ wlToText e.name}
      )
      h.objectID
      workspaces
  EvExtWorkspaceHandleV1_coordinates h e ->
    Map.alter
      ( \case
          Nothing -> pure $ PendingWorkspace Nothing (Just . fromIntegral $ sum e.coordinates) Nothing
          Just w -> pure w{pwCoordinates = Just . fromIntegral $ sum e.coordinates}
      )
      h.objectID
      workspaces
  EvExtWorkspaceHandleV1_state h e ->
    Map.alter
      ( \case
          Nothing -> pure $ PendingWorkspace Nothing Nothing (Just $ decodeState e.state)
          Just w -> pure w{pwState = Just $ decodeState e.state}
      )
      h.objectID
      workspaces
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

{- | Attempt to promote all pending workspaces to fully resolved ones.
Returns Nothing if any workspace is still missing fields.
Workspaces are sorted by coordinates so rendering order is stable.
-}
resolveWorkspaces :: WorkspaceMap -> Maybe [Workspace]
resolveWorkspaces m =
  sortOn (.wsCoordinates) <$> traverse promote (Map.elems m)
  where
    promote (PendingWorkspace (Just n) (Just c) (Just s)) =
      Just (Workspace n c s)
    promote _ = Nothing

getBarState :: IORef WorkspaceMap -> IORef BarState -> IO (Maybe BarState)
getBarState mapRef previousStateRef = do
  workspaces <- readIORef mapRef
  case resolveWorkspaces workspaces of
    Nothing -> pure Nothing
    Just ws -> do
      date <- getDate
      let newState = BarState date ws
      prevState <- readIORef previousStateRef
      if newState == prevState
        then pure Nothing
        else do
          writeIORef previousStateRef newState
          pure $ Just newState
  where
    getDate :: IO Text
    getDate = do
      (dateOut, _dateErr) <-
        readProcess_
          $ setEnv [("LC_ALL", "C")]
          $ proc "date" ["+%a %Y-%m(%B)-%d %H:%M"]
      pure . decodeUtf8 . BSL.reverse . BSL.drop 1 $ BSL.reverse dateOut

renderBarState :: Font -> BarState -> Image PixelRGBA8
renderBarState font barState = do
  let bgColor = PixelRGBA8 0 0 0 0
      drawColor = PixelRGBA8 213 196 161 255 -- #d5c4a1
      workspaceNames =
        T.intercalate " "
          $ mapMaybe
            ( \w -> case w.wsState of
                Hidden -> Nothing
                Active -> Just $ "[" <> w.wsName <> "]"
                _ -> Just w.wsName
            )
            barState.workspaces

  renderDrawing (fromIntegral bufferWidth) (fromIntegral bufferHeight) bgColor $ do
    withTexture (uniformTexture drawColor) $ do
      let text = mconcat [barState.date, " | ", workspaceNames]
      printTextAt font (PointSize 11) (V2 20 15) $ toString text
