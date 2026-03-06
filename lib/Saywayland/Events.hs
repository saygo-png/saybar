{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE UndecidableInstances #-}

{- HLINT ignore "Use camelCase" -}

module Saywayland.Events (module Saywayland.Events) where

import Data.Binary
import Data.Binary.Get
import Data.Binary.Put
import Data.ByteString.Lazy hiding (map)
import Data.ByteString.Lazy.Internal
import GHC.Generics
import Relude hiding (ByteString, Word32, get, isPrefixOf, put, replicate)
import Saywayland.Headers
import Saywayland.Internal.Utils
import Text.Printf


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

data WaylandEvent
  = EvWlDisplay_error Header BodyWlDisplay_error
  | EvWlDisplay_deleteID Header BodyWlDisplay_deleteId
  | EvGlobal Header BodyGlobal
  | EvWlShm_format Header BodyWlShm_format
  | EvWlrLayerSurface_configure Header BodyWlrLayerSurface_configure
  | EvExtWorkspaceManagerV1_workspace Header BodyExtWorkspaceManagerV1_workspace
  | EvExtWorkspaceManagerV1_workspaceGroup Header BodyExtWorkspaceManagerV1_workspaceGroup
  | EvExtWorkspaceManagerV1_done Header BodyExtWorkspaceManagerV1_done
  | EvExtWorkspaceHandleV1_id Header BodyExtWorkspaceHandleV1_id
  | EvExtWorkspaceHandleV1_name Header BodyExtWorkspaceHandleV1_name
  | EvExtWorkspaceHandleV1_coordinates Header BodyExtWorkspaceHandleV1_coordinates
  | EvExtWorkspaceHandleV1_state Header BodyExtWorkspaceHandleV1_state
  | EvExtWorkspaceHandleV1_capabilities Header BodyExtWorkspaceHandleV1_capabilities
  | EvExtWorkspaceHandleV1_removed Header BodyExtWorkspaceHandleV1_removed
  | EvBufferRelease Header
  | EvUnknown Header

type Globals = Map Word32 (Header, BodyGlobal)

data BodyGlobal = BodyGlobal
  { name :: Word32
  , interface :: ByteString
  , version :: Word32
  }
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyGlobal)

newtype BodyWlShm_format = BodyWlShm_format {format :: Word32}
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyWlShm_format)

data BodyWlDisplay_error = BodyWlDisplay_error
  { errorObjectID :: Word32
  , errorCode :: Word32
  , errorMessage :: ByteString
  }
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyWlDisplay_error)

newtype BodyWlDisplay_deleteId = BodyWlDisplay_deleteID {deletedID :: Word32}
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyWlDisplay_deleteId)

data BodyWlrLayerSurface_configure = BodyWlrLayerSurfaceConfigure
  { serial :: Word32
  , width :: Word32
  , height :: Word32
  }
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyWlrLayerSurface_configure)

newtype BodyExtWorkspaceManagerV1_workspace = BodyExtWorkspaceManagerV1_workspace
  {handleID :: Word32}
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyExtWorkspaceManagerV1_workspace)

newtype BodyExtWorkspaceManagerV1_workspaceGroup = BodyExtWorkspaceManagerV1_workspaceGroup
  {handleID :: Word32}
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyExtWorkspaceManagerV1_workspaceGroup)

data BodyExtWorkspaceManagerV1_done = BodyExtWorkspaceManagerV1_done
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyExtWorkspaceManagerV1_done)

newtype BodyExtWorkspaceHandleV1_id = BodyExtWorkspaceHandleV1_id
  {id :: ByteString}
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyExtWorkspaceHandleV1_id)

newtype BodyExtWorkspaceHandleV1_name = BodyExtWorkspaceHandleV1_name
  {name :: ByteString}
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyExtWorkspaceHandleV1_name)

newtype BodyExtWorkspaceHandleV1_coordinates = BodyExtWorkspaceHandleV1_coordinates
  {coordinates :: WlArray Word32}
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyExtWorkspaceHandleV1_coordinates)

newtype BodyExtWorkspaceHandleV1_state = BodyExtWorkspaceHandleV1_state
  {state :: Word32}
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyExtWorkspaceHandleV1_state)

newtype BodyExtWorkspaceHandleV1_capabilities = BodyExtWorkspaceHandleV1_capabilities
  {capabilities :: Word32}
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyExtWorkspaceHandleV1_capabilities)

data BodyExtWorkspaceHandleV1_removed = BodyExtWorkspaceHandleV1_removed
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyExtWorkspaceHandleV1_removed)

formatEvent :: WaylandEvent -> String
formatEvent = \case
  EvWlDisplay_error h e -> printf "wl_display@%i.error: object_id=%i code=%i message=%s" h.objectID e.errorObjectID e.errorCode (unpackChars e.errorMessage)
  EvWlDisplay_deleteID h e -> printf "wl_display@%i.delete_id: id=%i" h.objectID e.deletedID
  EvGlobal h e -> printf "wl_registry@%i.global: name=%i interface=%s version=%i" h.objectID e.name (unpackChars e.interface) e.version
  EvWlShm_format h e -> printf "wl_shm@%i.format: format=%s (%i)" h.objectID (formatName e.format) e.format
  EvWlrLayerSurface_configure h e -> printf "zwlr_layer_surface_v1@%i.configure: serial=%i width=%i height=%i" h.objectID e.serial e.width e.height
  EvExtWorkspaceManagerV1_workspace h e -> printf "ext_workspace_manager_v1@%i.workspace: handle=%i" h.objectID e.handleID
  EvExtWorkspaceManagerV1_workspaceGroup h e -> printf "ext_workspace_manager_v1@%i.workspace_group handle=%i: " h.objectID e.handleID
  EvExtWorkspaceManagerV1_done h _ -> printf "ext_workspace_manager_v1@%i.done: done sending workspace info" h.objectID
  EvExtWorkspaceHandleV1_id h e -> printf "ext_workspace_handle_v1@%i.id: id=%s" h.objectID (unpackChars e.id)
  EvExtWorkspaceHandleV1_name h e -> printf "ext_workspace_handle_v1@%i.name: name=%s" h.objectID (unpackChars e.name)
  EvExtWorkspaceHandleV1_coordinates h e -> printf "ext_workspace_handle_v1@%i.coordinates: coordinates=%s" h.objectID (show @Text e.coordinates)
  EvExtWorkspaceHandleV1_state h e -> printf "ext_workspace_handle_v1@%i.state: state=%i" h.objectID e.state
  EvExtWorkspaceHandleV1_capabilities h e -> printf "ext_workspace_handle_v1@%i.capabilities: capabilities=%i" h.objectID e.capabilities
  EvExtWorkspaceHandleV1_removed h _ -> printf "ext_workspace_handle_v1@%i.removed: removed" h.objectID
  EvBufferRelease h -> printf "wl_buffer@%i.release: buffer released" h.objectID
  EvUnknown h -> printf "???: objectID=%i opCode=%i size=%i" h.objectID h.opCode h.size

displayEvent :: WaylandEvent -> IO ()
displayEvent ev = putStrLn $ "<- " <> formatEvent ev

-- Format names for wl_shm
formatName :: Word32 -> String
formatName 0 = "ARGB8888"
formatName 1 = "XRGB8888"
formatName n = "format_" <> show n

-- Generic little-endian Binary deriving
type GBinaryLE :: forall {k}. (k -> Type) -> Constraint
class GBinaryLE f where
  ggetLE :: Get (f a)
  gputLE :: f a -> Put

instance GBinaryLE U1 where
  ggetLE = return U1
  gputLE U1 = return ()

instance (GBinaryLE a, GBinaryLE b) => GBinaryLE (a :*: b) where
  ggetLE = (:*:) <$> ggetLE <*> ggetLE
  gputLE (a :*: b) = gputLE a *> gputLE b

instance (GBinaryLE a) => GBinaryLE (M1 i c a) where
  ggetLE = M1 <$> ggetLE
  gputLE (M1 x) = gputLE x

instance GBinaryLE (K1 i Word32) where
  ggetLE = K1 <$> getWord32le
  gputLE (K1 x) = putWord32le x

instance GBinaryLE (K1 i Int32) where
  ggetLE = K1 <$> getInt32le
  gputLE (K1 x) = putInt32le x

instance GBinaryLE (K1 i ByteString) where
  ggetLE = K1 <$> getWlString
  gputLE (K1 x) = putWlString x

type role WlArray representational

newtype WlArray a = WlArray [a]
  deriving stock (Show)

instance GBinaryLE (K1 i (WlArray Word32)) where
  ggetLE = do
    len <- getWord32le
    bytes <- getLazyByteString $ padLen len
    let elems = runGet (replicateM (fromIntegral len `div` 4) getWord32le) bytes
    return $ K1 (WlArray elems)
  gputLE (K1 (WlArray xs)) = do
    let len = fromIntegral (Relude.length xs * 4) :: Word32
    putWord32le len
    mapM_ putWord32le xs

-- Newtype wrapper for deriving via
type role LittleEndian representational

newtype LittleEndian a = LittleEndian a

instance (Generic a, GBinaryLE (Rep a)) => Binary (LittleEndian a) where
  get = LittleEndian . to <$> ggetLE
  put (LittleEndian x) = gputLE (from x)
