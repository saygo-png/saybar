module Types (ObjectTracker (..), BarState (..), WhichBuffer (..)) where

import Data.Binary
import Relude hiding (ByteString, get, isPrefixOf, length, put, replicate)
import Saywayland.Types

data BarState = BarState
  { date :: Text
  }
  deriving stock (Show)

data WhichBuffer = BufferA | BufferB

data ObjectTracker = ObjectTracker
  { wl_surfaceID :: Maybe Word32
  , wl_shm_poolID :: Maybe Word32
  , wl_buffer_A :: Maybe Buffer
  , wl_buffer_B :: Maybe Buffer
  , zwlr_layer_surface_v1ID :: Maybe Word32
  , zwlr_layer_surface_v1Serial :: TMVar Word32
  }
