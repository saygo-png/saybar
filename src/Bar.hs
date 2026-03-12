module Bar (writeSwizzledRGBAtoBGRA, workspaceEventsHandler, renderBar) where

import Codec.Picture (PixelRGBA8 (..), imageData)
import Codec.Picture.Types (Image)
import Config
import Data.Bits
import Data.Map qualified as Map
import Data.Vector.Storable qualified as VS
import GHC.IO.Handle (hPutBuf)
import Graphics.Rasterific
import Graphics.Rasterific.Transformations
import Modules
import Relude hiding (ByteString, get, isPrefixOf, put)
import Saywayland
import Types

writeSwizzledRGBAtoBGRA :: Handle -> Image PixelRGBA8 -> IO ()
writeSwizzledRGBAtoBGRA handle image =
  VS.unsafeWith swizzled $ \ptr ->
    hPutBuf handle ptr (VS.length swizzled)
  where
    px = imageData image
    premul c a = fromIntegral (fromIntegral c * fromIntegral a `div` 255 :: Word16)
    swizzled = VS.generate (VS.length px) $ \i ->
      let base = (i `div` 4) * 4
          r = VS.unsafeIndex px base
          g = VS.unsafeIndex px (base + 1)
          b = VS.unsafeIndex px (base + 2)
          a = VS.unsafeIndex px (base + 3)
       in case i `mod` 4 of
            0 -> premul b a
            1 -> premul g a
            2 -> premul r a
            _ -> a

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

{- | Run every module left-to-right, compose their drawings, rasterize.
  Each module's render function returns the pixel width it consumed,
  which advances the cursor for the next module.
-}
renderBar :: RenderCtx -> [Either Spacer BarModule] -> IO (Image PixelRGBA8)
renderBar ctx modules = do
  let margin :: Float = 0
  let bgColor = PixelRGBA8 0 0 0 0
  drawings <- mapM (runModule ctx) modules
  let drawing = composeDrawings drawings
  pure $ renderDrawing (fromIntegral bufferWidth) (fromIntegral bufferHeight) bgColor drawing
  where
    gapBetweenModules :: Float = 0

    -- At what height to render at>
    baseline :: Float = fromIntegral bufferHeight * 0.75

    composeDrawings :: [Either Spacer (RenderResult, Float)] -> RenderResult
    composeDrawings barElements = go 0 barElements
      where
        spacerWidth = (bufferWidthF - elementsWidth) / spacerCount
          where
            elementsWidth = sum $ snd <$> rights barElements
            bufferWidthF :: Float = fromIntegral bufferWidth
            spacerCount = fromIntegral . length $ lefts barElements
        go :: Float -> [Either Spacer (RenderResult, Float)] -> RenderResult
        go _ [] = mempty
        go margin ((Right (drawing, width)) : rest) = do
          let otherDrawings = go (margin + width) rest
          let transformedDrawing = do
                withTransformation (translate (V2 margin baseline)) drawing
          mconcat [transformedDrawing, otherDrawings]
        go margin ((Left Spacer) : rest) = go (margin + spacerWidth) rest
