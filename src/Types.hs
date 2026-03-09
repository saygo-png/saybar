{-# OPTIONS_GHC -Wno-missing-export-lists #-}

module Types where

import Relude
import Saywayland

type WorkspaceMap = Map WlID WorkspaceInfo

data WorkspaceState = Active | Urgent | Hidden | Inactive
  deriving stock (Show, Eq, Ord)

data WorkspaceInfo = WorkspaceInfo
  { wsName :: Text
  , wsState :: WorkspaceState
  }
  deriving stock (Show)

data BarState = BarState
  { date :: Text
  , workspaces :: [WorkspaceInfo]
  }
  deriving stock (Show)
