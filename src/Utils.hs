module Utils (onEventDo, fi) where

import Relude
import Sayland
import Sayland.Internal.Core (getConnectionEnv)

onEventDo :: (Message e) => (AnyObjectID -> e -> Wayland Client ()) -> Wayland Client ()
onEventDo handler = do
  env <- getConnectionEnv
  modifyIORef env.eventHandlers (EventHandler handler :)

fi :: forall a b. (Integral a, Num b) => a -> b
fi = fromIntegral
