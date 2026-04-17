module Modules (module Modules) where

import Codec.Picture (PixelRGBA8 (PixelRGBA8))
import Control.Concurrent (forkIO, threadDelay)
import Data.Text qualified as T
import Data.Time (formatTime)
import Data.Time.Format (defaultTimeLocale)
import Data.Time.LocalTime (getZonedTime)
import Foreign (Ptr)
import Generated.Fcft (Fcft_font)
import Relude hiding (ByteString, get, isPrefixOf, put)
import RenderText (getGlyphs, renderGlyphs)
import Saywayland
import Types
import Saywayland.Types

-- | How a module decides when to refresh.
data ModuleTrigger
  = -- | interval in milliseconds
    OnTimer Int
  | -- | react to a Wayland event
    OnWaylandEvent (WaylandEvent -> Wayland ())

data RenderCtx = RenderCtx
  { font :: Ptr Fcft_font
  , fontSize :: Int
  , drawColor :: PixelRGBA8
  }

type RenderFrom a = RenderCtx -> a -> IO (RenderResult, Float)

data BarModule = forall a. BarModule
  { trigger :: ModuleTrigger
  , getData :: IO a
  , render :: RenderFrom a
  }

data Spacer = Spacer

runModule :: RenderCtx -> Either Spacer BarModule -> IO (Either Spacer (RenderResult, Float))
runModule ctx = traverse (\(BarModule _ getData render) -> getData >>= render ctx)

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
renderDate ctx t = do
  textRun <- getGlyphs ctx.font t
  renderGlyphs ctx.font textRun ctx.drawColor 0 0

-- | Current date/time, refreshed every second.
dateModule :: BarModule
dateModule =
  BarModule
    { trigger = OnTimer 3000
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
renderWorkspaces ctx workspaces = do
  textRun <- getGlyphs ctx.font visible
  renderGlyphs ctx.font textRun ctx.drawColor 0 0
  where
    -- TODO: implement different colors
    activeColor = PixelRGBA8 251 241 199 255
    urgentColor = PixelRGBA8 251 73 52 255

    visible = T.intercalate " " $ mapMaybe toLabel workspaces

    toLabel w = case w.wsState of
      Hidden -> Nothing
      Active -> Just ("[" <> w.wsName <> "]")
      Urgent -> Just ("!" <> w.wsName <> "!")
      Inactive -> Just w.wsName

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
