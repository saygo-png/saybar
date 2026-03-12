module Main (main) where

import Bar (renderBar, writeSwizzledRGBAtoBGRA)
import Codec.Picture.Types
import Config (bufferHeight, bufferWidth, makeModules)
import Criterion.Main
import Graphics.Text.TrueType (PointSize (..), loadFontFile)
import Modules (RenderCtx (..), renderDate, renderWorkspaces)
import Relude
import System.IO (openFile)
import Types

-- ---------------------------------------------------------------------------
-- Shared fixtures

-- | Full-size 1920×20 test image with a colour gradient, matching bar dimensions.
testImage :: Image PixelRGBA8
testImage =
  generateImage
    (\x y -> PixelRGBA8 (fromIntegral (x `mod` 256)) (fromIntegral (y `mod` 256)) 128 200)
    (fromIntegral bufferWidth)
    (fromIntegral bufferHeight)

-- | Representative date string produced by dateModule.
sampleDate :: Text
sampleDate = "Thu 2026-03(March)-12 10:00"

-- | Small but varied workspace list covering every visible state.
sampleWorkspaces :: [Workspace]
sampleWorkspaces =
  [ Workspace "1" 0 Active
  , Workspace "2" 1 Inactive
  , Workspace "3" 2 Urgent
  , Workspace "4" 3 Inactive
  ]

-- ---------------------------------------------------------------------------
-- Main

main :: IO ()
main = do
  -- Load the font once; all module/render benchmarks share it.
  font <- either (error . toText) pure =<< loadFontFile "CourierPrime-Regular.ttf"

  -- Sink used by the IO-based swizzle benchmark; /dev/null discards bytes
  -- without allocating, keeping the measurement focused on the swizzle work.
  devNull <- openFile "/dev/null" WriteMode

  wsVar <- newTVarIO sampleWorkspaces

  let ctx =
        RenderCtx
          { font = font
          , fontSize = PointSize 11
          , dpi = 96
          , drawColor = PixelRGBA8 213 196 161 255
          }

  let modules = makeModules wsVar

  defaultMain
    [ -- -----------------------------------------------------------------------
      -- Swizzle: RGBA -> BGRA conversion + alpha pre-multiplication.
      --
      -- swizzleRGBAtoBGRA   – pure, allocates a lazy ByteString; nf forces it.
      -- writeSwizzledRGBAtoBGRA – IO, builds a storable Vector then hPutBuf;
      --                           whnfIO is sufficient because the result is ().
      bgroup
        "swizzle"
        [ bench "writeSwizzledRGBAtoBGRA/1920x20"
            $ whnfIO (writeSwizzledRGBAtoBGRA devNull testImage)
        ]
    , -- -----------------------------------------------------------------------
      -- Module rendering: pure (RenderCtx -> data -> (Drawing, Float)).
      --
      -- Drawing is a lazy monadic value, so whnf evaluates the outer tuple,
      -- forcing the Float (bounding-box width) while leaving the drawing as a
      -- thunk.  The full drawing cost is exercised by the renderBar group below.
      bgroup
        "modules"
        [ bench "renderDate"
            $ whnf (renderDate ctx) sampleDate
        , bench "renderWorkspaces/4ws"
            $ whnf (renderWorkspaces ctx) sampleWorkspaces
        ]
    , -- -----------------------------------------------------------------------
      -- Full pipeline: collect all module data, compose drawings, rasterize.
      -- renderBar calls renderDrawing which forces the entire Drawing into an
      -- Image, so this is the most complete end-to-end measurement.
      bgroup
        "render"
        [ bench "renderBar/full"
            $ whnfIO (renderBar ctx modules)
        ]
    ]
