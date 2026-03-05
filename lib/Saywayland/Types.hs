module Saywayland.Types (WaylandInterface (..), Wayland, WaylandEnv (..), Buffer (..), Serial (..)) where

import Data.Binary
import Network.Socket
import Relude hiding (ByteString, get, isPrefixOf, length, put, replicate)
import Saywayland.Events (Globals)

type Wayland = ReaderT WaylandEnv IO

data WaylandInterface
  = WlSurface
  | WlShmPool
  | WlBuffer
  | WlCompositor
  | ZwlrLayerSurfaceV1
  | ZwlrLayerShellV1
  | WlDisplay
  | WlRegistry
  | WlShm
  | ExtWorkspaceManagerV1
  | ExtWorkspaceHandleV1
  deriving stock (Show)

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
