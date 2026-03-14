module Modules (module Modules) where

import Codec.Picture (PixelRGBA8 (PixelRGBA8))
import Control.Concurrent (forkIO, threadDelay)
import Data.Time (formatTime)
import Data.Time.Format (defaultTimeLocale)
import Data.Time.LocalTime (getZonedTime)
import Graphics.Rasterific
import Graphics.Rasterific.Texture
import Graphics.Text.TrueType (BoundingBox (..), Font, stringBoundingBox)
import Relude hiding (ByteString, get, isPrefixOf, put)
import Saywayland
import Types

-- | How a module decides when to refresh.
data ModuleTrigger
  = -- | interval in milliseconds
    OnTimer Int
  | -- | react to a Wayland event
    OnWaylandEvent (WaylandEvent -> Wayland ())

data RenderCtx = RenderCtx
  { font :: Font
  , fontSize :: PointSize
  , dpi :: Int
  , drawColor :: PixelRGBA8
  }

type RenderFrom a = RenderCtx -> a -> (RenderResult, Float)

data BarModule = forall a. BarModule
  { trigger :: ModuleTrigger
  , getData :: IO a
  , render :: RenderFrom a
  }

data Spacer = Spacer

runModule :: RenderCtx -> Either Spacer BarModule -> IO (Either Spacer (RenderResult, Float))
runModule ctx (Right (BarModule _ getData render)) =
  Right . render ctx <$> getData
runModule _ (Left Spacer) = pure $ Left Spacer

textWidth :: RenderCtx -> Text -> Float
textWidth ctx str =
  let bb = stringBoundingBox ctx.font ctx.dpi ctx.fontSize $ toString str
   in bb._xMax

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

-- | Render a date/time string at the origin.
renderDate :: RenderFrom Text
renderDate ctx t =
  ( withTexture (uniformTexture ctx.drawColor)
      $ printTextAt ctx.font ctx.fontSize (V2 0 0) (toString t)
  , textWidth ctx t
  )

-- | Current date/time, refreshed every second.
dateModule :: BarModule
dateModule =
  BarModule
    { trigger = OnTimer 60000
    , getData = getDate
    , render = renderDate
    }
  where
    getDate :: IO Text
    getDate = do
      now <- getZonedTime
      pure . toText $ formatTime defaultTimeLocale "%a %Y-%m(%B)-%d %H:%M" now

{- | Render the workspace list.
  Active workspace is highlighted, Urgent is red, Hidden is skipped.
-}
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
                (printTextAt ctx.font ctx.fontSize (V2 curX 0) (toString label))
          nextX = curX + textWidth ctx label + spacing
       in (drawing, nextX)

{- | Workspace list.
  Pass a TVar kept up to date by workspaceEventsHandler in Bar.hs.
-}
workspaceModule :: TVar [Workspace] -> BarModule
workspaceModule wsVar =
  BarModule
    { trigger = OnWaylandEvent (\_ -> pure ()) -- wakeUp driven by done-event in Main
    , getData = readTVarIO wsVar
    , render = renderWorkspaces
    }
