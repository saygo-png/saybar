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

data WaylandEvent
  = EvWlDisplay_error Header BodyWlDisplay_error
  | EvWlDisplay_deleteID Header BodyWlDisplay_deleteId
  | EvGlobal Header BodyGlobal
  | EvWlShm_format Header BodyWlShm_format
  | EvWlrLayerSurface_configure Header BodyWlrLayerSurface_configure
  | EvExtWorkspaceManagerV1_workspace Header BodyExtWorkspaceManagerV1_workspace
  | EvBufferRelease Header
  | EvUnknown Header

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

type Globals = Map Word32 (Header, BodyGlobal)

data BodyGlobal = EventGlobal
  { name :: Word32
  , interface :: ByteString
  , version :: Word32
  }
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyGlobal)

newtype BodyWlShm_format = EventShmFormat {format :: Word32}
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyWlShm_format)

data BodyWlDisplay_error = EventDisplayError
  { errorObjectId :: Word32
  , errorCode :: Word32
  , errorMessage :: ByteString
  }
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyWlDisplay_error)

newtype BodyWlDisplay_deleteId = EventDisplayDeleteId {deletedId :: Word32}
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyWlDisplay_deleteId)

data BodyWlrLayerSurface_configure = EventWlrLayerSurfaceConfigure
  { serial :: Word32
  , width :: Word32
  , height :: Word32
  }
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyWlrLayerSurface_configure)

newtype BodyExtWorkspaceManagerV1_workspace = EventExtWorkspaceManagerV1_workspace
  { handleID :: Word32
  }
  deriving stock (Generic, Show)
  deriving (Binary) via (LittleEndian BodyExtWorkspaceManagerV1_workspace)

-- Single function replacing the WaylandEventType typeclass
formatEvent :: WaylandEvent -> String
formatEvent = \case
  EvWlDisplay_error h e ->
    printf
      "wl_display@%i.error: object_id=%i code=%i message=\"%s\""
      h.objectID
      e.errorObjectId
      e.errorCode
      (unpackChars e.errorMessage)
  EvWlDisplay_deleteID h e ->
    printf "wl_display@%i.delete_id: id=%i" h.objectID e.deletedId
  EvGlobal h e ->
    printf
      "wl_registry@%i.global: name=%i interface=\"%s\" version=%i"
      h.objectID
      e.name
      (unpackChars e.interface)
      e.version
  EvWlShm_format h e ->
    printf
      "wl_shm@%i.format: format=%s (%i)"
      h.objectID
      (formatName e.format)
      e.format
  EvWlrLayerSurface_configure h e ->
    printf
      "zwlr_layer_surface_v1@%i.configure: serial=%i width=%i height=%i"
      h.objectID
      e.serial
      e.width
      e.height
  EvExtWorkspaceManagerV1_workspace h e ->
    printf
      "ext_workspace_manager_v1@%i.workspace: handle=%i"
      h.objectID
      e.handleID
  EvBufferRelease h ->
    printf "wl_buffer@%i.release: buffer released" h.objectID
  EvUnknown h ->
    printf "<- unknown event: objectID=%i opCode=%i size=%i" h.objectID h.opCode h.size

displayEvent :: WaylandEvent -> IO ()
displayEvent ev = putStrLn $ "<- " <> formatEvent ev

-- Format names for wl_shm
formatName :: Word32 -> String
formatName 0 = "ARGB8888"
formatName 1 = "XRGB8888"
formatName n = "format_" <> show n
