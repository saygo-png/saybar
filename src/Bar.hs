module Bar (writeSwizzledRGBAtoBGRA, workspaceEventsHandler, renderBar) where

import Codec.Picture
import Config
import Data.Bits
import Data.Map qualified as Map
import Data.Vector.Storable qualified as VS
import GHC.IO.Handle (hPutBuf)
import Modules
import Relude hiding (ByteString, get, isPrefixOf, put)
import RenderText
import Saywayland
import Types

-- | Convert RGBA to BGRA (A format understood by Wayland)
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
  which is used to advance the pen for the next module.
-}
renderBar :: RenderCtx -> [Either Spacer BarModule] -> IO (Image PixelRGBA8)
renderBar ctx modules = do
  drawings <- mapM (runModule ctx) modules
  let finalGlyphs = map (translateGlyph 0 (-13)) $ composeDrawings drawings
  -- Use the pre-defined buffer dimensions to create the final image.
  pure $ generateCanvas (fromIntegral bufferWidth) (fromIntegral bufferHeight) finalGlyphs
  where
    gapBetweenModules :: Float = 0
    baseline :: Float = fromIntegral bufferHeight * 0.75

    composeDrawings :: [Either Spacer (RenderResult, Float)] -> RenderResult
    composeDrawings barElements = go 0 barElements
      where
        bufferWidthF :: Float = fromIntegral bufferWidth
        elementsWidth = sum $ snd <$> rights barElements
        spacerCount = fromIntegral . length $ lefts barElements
        -- Avoid division by zero if there are no spacers
        spacerWidth =
          if spacerCount > 0
            then (bufferWidthF - elementsWidth) / spacerCount
            else 0

        go :: Float -> [Either Spacer (RenderResult, Float)] -> RenderResult
        go _ [] = []
        go margin (Right (glyphs, width) : rest) =
          let
            -- Shift these glyphs to the current margin and baseline
            positioned = map (translateGlyph margin baseline) glyphs
            -- Continue with the rest
            others = go (margin + width) rest
           in
            positioned ++ others
        go margin (Left Spacer : rest) =
          go (margin + gapBetweenModules + spacerWidth) rest
