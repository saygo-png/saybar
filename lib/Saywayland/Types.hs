module Saywayland.Types (Wayland, WaylandEnv (..), Buffer (..), Serial (..)) where

import Data.Binary
import Network.Socket
import Relude hiding (ByteString, get, isPrefixOf, length, put, replicate)
import Saywayland.Events (Globals, WaylandInterface)

type Wayland = ReaderT WaylandEnv IO

data Serial = Serial
  { serialCode :: Word32
  , originInterface :: WaylandInterface
  , originID :: Word32
  }

data WaylandEnv = WaylandEnv
  { socket :: Socket
  , counter :: IORef Word32
  , globals :: IORef Globals
  , objects :: IORef (Map Word32 WaylandInterface)
  , serial :: TMVar Word32
  , freeBuffer :: MVar ()
  }

data Buffer = Buffer
  { id :: Word32
  , offset :: Word32
  }
