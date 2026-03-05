module Saywayland (module Saywayland.Events, module Saywayland.Headers, module Saywayland.Utils, module Saywayland.Requests, module Saywayland.Types, parseEvent, eventLoop, handleEventResponse, processBuffer) where

import Data.Binary
import Data.Binary.Get hiding (remaining)
import Data.ByteString qualified as BS
import Data.ByteString.Lazy qualified as BSL
import Data.Map qualified as Map
import Relude hiding (get)
import Saywayland.Events
import Saywayland.Headers
import Saywayland.Internal.Utils
import Saywayland.Requests
import Saywayland.Types
import Saywayland.Utils

parseEvent :: Map Word32 WaylandInterface -> Get WaylandEvent
parseEvent objects = do
  header <- get
  let bodySize = fromIntegral header.size - 8
  case (Map.lookup header.objectID objects, header.opCode) of
    (Just WlDisplay, 0) -> EvWlDisplay_error header <$> get
    (Just WlDisplay, 1) -> EvWlDisplay_deleteID header <$> get
    --
    (Just WlRegistry, 0) -> EvGlobal header <$> get
    (Just WlShm, 0) -> EvWlShm_format header <$> get
    (Just ZwlrLayerSurfaceV1, 0) -> EvWlrLayerSurface_configure header <$> get
    (Just WlBuffer, 0) -> pure $ EvBufferRelease header
    --
    (Just ExtWorkspaceManagerV1, 0) -> EvExtWorkspaceManagerV1_workspaceGroup header <$> get
    (Just ExtWorkspaceManagerV1, 1) -> EvExtWorkspaceManagerV1_workspace header <$> get
    (Just ExtWorkspaceManagerV1, 2) -> EvExtWorkspaceManagerV1_done header <$> get
    --
    (Just ExtWorkspaceHandleV1, 0) -> EvExtWorkspaceHandleV1_id header <$> get
    (Just ExtWorkspaceHandleV1, 1) -> EvExtWorkspaceHandleV1_name header <$> get
    (Just ExtWorkspaceHandleV1, 2) -> EvExtWorkspaceHandleV1_coordinates header <$> get
    (Just ExtWorkspaceHandleV1, 3) -> EvExtWorkspaceHandleV1_state header <$> get
    (Just ExtWorkspaceHandleV1, 4) -> EvExtWorkspaceHandleV1_capabilities header <$> get
    (Just ExtWorkspaceHandleV1, 5) -> EvExtWorkspaceHandleV1_removed header <$> get
    _ -> skip bodySize $> EvUnknown header

eventLoop :: Wayland ()
eventLoop = do
  env <- ask
  msg <- liftIO $ receiveSocketData env.socket
  unless (BSL.null msg) $ processBuffer (BS.toStrict msg)
  eventLoop

processBuffer :: BS.ByteString -> Wayland ()
processBuffer bytes = do
  env <- ask
  objects <- liftIO $ readIORef env.objects
  case pushChunk (runGetIncremental (parseEvent objects)) bytes of
    Done remaining _ event -> do
      liftIO $ case event of
        EvBufferRelease _ -> do pure ()
        _ -> displayEvent event
      handleEventResponse event
      unless (BS.null remaining)
        $ processBuffer remaining
    Partial _ ->
      return () -- incomplete message, wait for next socket read
    Fail _ _ err ->
      liftIO $ putStrLn $ "Parse error: " <> err

handleEventResponse :: WaylandEvent -> Wayland ()
handleEventResponse (EvBufferRelease _) = takeMVar =<< asks (.freeBuffer)
handleEventResponse (EvGlobal h ev) = do
  globals <- asks (.globals)
  modifyIORef globals $ Map.insert ev.name (h, ev)
handleEventResponse (EvWlrLayerSurface_configure _ ev) = do
  serial <- asks (.serial)
  atomically $ putTMVar serial ev.serial
handleEventResponse (EvExtWorkspaceManagerV1_workspace _ ev) = do
  objects <- asks (.objects)
  modifyIORef objects $ Map.insert ev.handleID ExtWorkspaceHandleV1
handleEventResponse _ = return ()
