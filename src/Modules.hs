module Modules (module Modules) where

import Codec.Picture (PixelRGBA8 (PixelRGBA8))
import Control.Concurrent (forkIO, threadDelay)
import Data.ByteString.Lazy qualified as BSL
import Data.Text qualified as T
import Graphics.Rasterific
import Graphics.Rasterific.Texture
import Graphics.Text.TrueType (Font)
import Relude hiding (ByteString, get, isPrefixOf, put)
import Saywayland
import System.Process.Typed
import Types

-- | How a module decides when to refresh.
data ModuleTrigger
  = -- | interval in milliseconds
    OnTimer Int
  | -- | react to a Wayland event
    OnWaylandEvent (WaylandEvent -> Wayland ())

data RenderCtx = RenderCtx
  { font :: Font
  , drawColor :: PixelRGBA8
  }

type RenderFrom a = RenderCtx -> a -> (RenderResult, Float)

data BarModule = forall a. BarModule
  { trigger :: ModuleTrigger
  , getData :: IO a
  , render :: RenderFrom a
  }

-- | Fetch a module's data and produce (Drawing, widthConsumed).
runModule :: RenderCtx -> BarModule -> IO (RenderResult, Float)
runModule ctx (BarModule _ getData render) =
  render ctx <$> getData

{- | Start all modules.
  Timer modules fork a background thread that nudges wakeUp each tick.
  Event modules register an onEvent handler.
-}
startModules :: [BarModule] -> TMVar () -> Wayland ()
startModules mods wakeUp =
  forM_ mods $ \(BarModule trig _ _) -> case trig of
    OnTimer interval ->
      liftIO . void . forkIO . forever $ do
        threadDelay (interval * 1000)
        atomically $ void $ tryPutTMVar wakeUp ()
    OnWaylandEvent handler ->
      onEvent handler

-- | Current date/time, refreshed every second.
dateModule :: BarModule
dateModule =
  BarModule
    { trigger = OnTimer 1000
    , getData = getDate
    , render = renderDate
    }
  where
    getDate :: IO Text
    getDate = do
      (out, _) <-
        readProcess_
          $ setEnv [("LC_ALL", "C")]
          $ proc "date" ["+%a %Y-%m(%B)-%d %H:%M"]
      pure . decodeUtf8 . BSL.reverse . BSL.drop 1 $ BSL.reverse out

    renderDate :: RenderFrom Text
    renderDate ctx t =
      ( withTexture (uniformTexture ctx.drawColor)
          $ printTextAt ctx.font (PointSize 11) (V2 0 0) (toString t)
      , fromIntegral (T.length t) * 8.0
      )

{- | Workspace list.
  Active workspace is highlighted, Urgent is red, Hidden is skipped.
  Pass a TVar kept up to date by workspaceEventsHandler in Bar.hs.
-}
workspaceModule :: TVar [Workspace] -> BarModule
workspaceModule wsVar =
  BarModule
    { trigger = OnWaylandEvent (\_ -> pure ()) -- wakeUp driven by done-event in Main
    , getData = readTVarIO wsVar
    , render = renderWorkspaces
    }
  where
    renderWorkspaces :: RenderFrom [Workspace]
    renderWorkspaces ctx workspaces =
      foldl' drawOne (pure (), 0) visible
      where
        spacing :: Float = 10
        activeColor = PixelRGBA8 251 241 199 255
        urgentColor = PixelRGBA8 251 73 52 255

        visible = mapMaybe toLabel workspaces
        toLabel w = case w.wsState of
          Hidden -> Nothing
          Active -> Just ("[" <> w.wsName <> "]", activeColor)
          Urgent -> Just ("!" <> w.wsName <> "!", urgentColor)
          Inactive -> Just (w.wsName, ctx.drawColor)

        drawOne (acc, curX) (label, color) =
          let drawing =
                acc
                  >> withTexture
                    (uniformTexture color)
                    (printTextAt ctx.font (PointSize 11) (V2 curX 0) (toString label))
              nextX = curX + fromIntegral (T.length label) * 8.0 + spacing
           in (drawing, nextX)
