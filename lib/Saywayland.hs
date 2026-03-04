module Saywayland (module Saywayland.Events, module Saywayland.Headers, module Saywayland.Utils, module Saywayland.Requests, module Saywayland.Types, parseEvent, eventLoop, handleEventResponse, processBuffer) where

import Data.Binary
import Data.Binary.Get hiding (remaining)
import Data.ByteString qualified as BS
import Data.ByteString.Lazy qualified as BSL
import Data.Map qualified as Map
import Data.Typeable
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
      ev :: (Binary a, WaylandEventType a, Typeable a) => Get a -> Get WaylandEvent
      ev = fmap (Event header)
  case (Map.lookup header.objectID objects, header.opCode) of
    (Just WlDisplay, 0) -> ev (get @EventDisplayError)
    (Just WlDisplay, 1) -> ev (get @EventDisplayDeleteId)
    (Just WlRegistry, 0) -> ev (get @EventGlobal)
    (Just WlShm, 0) -> ev (get @EventShmFormat)
    (Just ZwlrLayerSurfaceV1, 0) -> ev (get @EventWlrLayerSurfaceConfigure)
    (Just WlBuffer, 0) -> pure $ EvEmpty header EventBufferRelease
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
      liftIO $ displayEvent event
      handleEventResponse event
      unless (BS.null remaining)
        $ processBuffer remaining
    Partial _ ->
      return () -- incomplete message, wait for next socket read
    Fail _ _ err ->
      liftIO $ putStrLn $ "Parse error: " <> err

handleEventResponse :: WaylandEvent -> Wayland ()
handleEventResponse (Event h e)
  | Just (ev :: EventGlobal) <- cast e = do
      globals <- asks (.globals)
      modifyIORef globals $ Map.insert ev.name (h, ev)
handleEventResponse (Event _ e)
  | Just (ev :: EventWlrLayerSurfaceConfigure) <- cast e = do
      serial <- asks (.serial)
      atomically $ putTMVar serial ev.serial
handleEventResponse (EvEmpty _ e)
  | Just (_ :: EventBufferRelease) <- cast e =
      takeMVar =<< asks (.freeBuffer)
handleEventResponse _ = return ()
