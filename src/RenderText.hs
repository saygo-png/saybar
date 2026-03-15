module RenderText (getGlyphs, renderGlyphs, translateGlyph, generateCanvas) where

import Codec.Picture
import Codec.Picture.Types
import Control.Monad (foldM)
import Control.Monad.ST
import Data.Ix (inRange)
import Data.Text qualified as T
import Foreign
import Foreign qualified as Marshal
import Foreign.C
import Generated.Fcft
import Generated.Fcft.FunPtr qualified as FunPtr
import HsBindgen.Runtime.Marshal qualified as Marshal
import HsBindgen.Runtime.PtrConst qualified as PtrConst
import Manual.Fcft
import Relude
import Types

getGlyphs :: Ptr Fcft_font -> Text -> IO (ForeignPtr Fcft_text_run)
getGlyphs font text =
  withArrayLen
    charCodes
    ( \len charCodesPtr -> do
        ptr <- fcft_rasterize_text_run_utf32 font (fromIntegral len) (PtrConst.unsafeFromPtr charCodesPtr) FCFT_SUBPIXEL_DEFAULT
        newForeignPtr FunPtr.fcft_text_run_destroy ptr
    )
  where
    charCodes = map (fromIntegral . fromEnum) (T.unpack text) :: [Word32]

renderGlyphs ::
  Ptr Fcft_font ->
  ForeignPtr Fcft_text_run ->
  -- | foreground colour
  PixelRGBA8 ->
  -- | pen_x
  Int ->
  -- | pen_y (baseline)
  Int ->
  IO ([RenderedGlyph], Float)
renderGlyphs font textRunForeign fgColour penX penY = do
  ascent <- fromIntegral . fcft_font_ascent <$> Marshal.readRaw font
  withForeignPtr
    textRunForeign
    ( \textRunPtr -> do
        textRunVal <- Marshal.readRaw textRunPtr
        glyphsArr <- Marshal.peekArray (fromIntegral textRunVal.fcft_text_run_count) textRunVal.fcft_text_run_glyphs
        bimap reverse fromIntegral . swap <$> foldM (stepGlyph ascent) (penX, []) glyphsArr
    )
  where
    stepGlyph ascent (currentPenX, acc) glyphPtr = do
      (rendered, advanceX) <- renderGlyph ascent currentPenX glyphPtr
      pure (currentPenX + advanceX, rendered : acc)

    renderGlyph ascent currentPenX glyphPtr = do
      glyph <- PtrConst.peek glyphPtr
      let bearingX = fromIntegral (fcft_glyph_x glyph)
          bearingY = fromIntegral (fcft_glyph_y glyph)
          glyphW = fromIntegral (fcft_glyph_width glyph)
          glyphH = fromIntegral (fcft_glyph_height glyph)
          advanceX = fromIntegral (fcft_glyph_advance_x (fcft_glyph_advance glyph))
          originX = currentPenX + bearingX
          originY = penY + ascent - bearingY

      pixelData <- castPtr <$> pixman_image_get_data (fcft_glyph_pix glyph) :: IO (Ptr Word8)
      CInt byteStride <- pixman_image_get_stride (fcft_glyph_pix glyph)
      glyphImage <- newMutableImage glyphW glyphH

      for_ [0 .. glyphH - 1] $ \row ->
        for_ [0 .. glyphW - 1] $ \col -> do
          alpha <- peekElemOff pixelData (row * fromIntegral byteStride + col)
          blitPixel glyphImage row col alpha

      frozenImage <- freezeImage glyphImage
      pure (RenderedGlyph frozenImage originX originY, advanceX)

    blitPixel glyphImage row col alpha = case alpha of
      0 -> pure ()
      255 -> writePixel glyphImage col row fgColour
      a -> do
        pixel <- readPixel glyphImage col row
        writePixel glyphImage col row $ blendPixel a fgColour pixel

    blendPixel alpha (PixelRGBA8 fgR fgG fgB _) (PixelRGBA8 bgR bgG bgB _) =
      let alphaN = fromIntegral alpha :: Word32
          alphaI = 255 - alphaN
          mix fg bg = fromIntegral $ (fromIntegral fg * alphaN + fromIntegral bg * alphaI) `div` 255
       in PixelRGBA8 (mix fgR bgR) (mix fgG bgG) (mix fgB bgB) 255

-- | Move a glyph by an offset.
translateGlyph :: Float -> Float -> RenderedGlyph -> RenderedGlyph
translateGlyph dx dy g =
  g
    { rgX = g.rgX + round dx
    , rgY = g.rgY + round dy
    }

-- | Blit glyphs onto a canvas.
generateCanvas :: Int -> Int -> [RenderedGlyph] -> Image PixelRGBA8
generateCanvas w h glyphs = runST $ do
  -- Initialize a transparent canvas
  canvas <- createMutableImage w h (PixelRGBA8 0 0 0 0)

  forM_ glyphs $ \glyph -> do
    let glyphImg = glyph.rgImage
        glyphBaseX = glyph.rgX
        glyphBaseY = glyph.rgY
        glyphImgW = glyphImg.imageWidth
        glyphImgH = glyphImg.imageHeight

    -- Stamp each pixel of the glyph onto the canvas
    forM_ [0 .. glyphImgW - 1] $ \x ->
      forM_ [0 .. glyphImgH - 1] $ \y -> do
        let targetX = glyphBaseX + x
            targetY = glyphBaseY + y
        -- Boundary check to prevent crashes if a glyph peaks off-screen
        when (inRange ((0, 0), (w - 1, h - 1)) (targetX, targetY)) $ do
          let newPixel = pixelAt glyphImg x y
          writePixel canvas targetX targetY newPixel

  unsafeFreezeImage canvas
