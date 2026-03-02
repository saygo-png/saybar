module Types (BarState (..)) where

import Relude

data BarState = BarState
  { date :: Text
  }
  deriving stock (Show)
