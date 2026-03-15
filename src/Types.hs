{-# LANGUAGE DeriveAnyClass #-}
{-# OPTIONS_GHC -Wno-missing-export-lists #-}

module Types where

import Codec.Picture (Image, PixelRGBA8)
import Relude
import Saywayland

data WorkspaceState = Active | Urgent | Hidden | Inactive
  deriving stock (Show, Eq, Ord, Generic)
  deriving anyclass (NFData)

-- Accumulation phase: all fields optional as events trickle in
data PendingWorkspace = PendingWorkspace
  { pwName :: Maybe Text
  , pwCoordinates :: Maybe Int
  , pwState :: Maybe WorkspaceState
  }
  deriving stock (Show, Generic)
  deriving anyclass (NFData)

-- Render phase: fully resolved, no Maybes, safe to use directly
data Workspace = Workspace
  { wsName :: Text
  , wsCoordinates :: Int
  , wsState :: WorkspaceState
  }
  deriving stock (Show, Eq, Generic)
  deriving anyclass (NFData)

type WorkspaceMap = Map WlID PendingWorkspace

data BarState = BarState
  { date :: Text
  , workspaces :: [Workspace]
  }
  deriving stock (Show, Eq, Generic)
  deriving anyclass (NFData)

type RenderResult = [RenderedGlyph]

data RenderedGlyph = RenderedGlyph
  { rgImage :: !(Image PixelRGBA8)
  , rgX :: !Int -- top-left x in pen-coordinate space
  , rgY :: !Int -- top-left y in pen-coordinate space
  }
