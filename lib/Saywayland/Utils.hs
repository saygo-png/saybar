module Saywayland.Utils (findInterface, bindToInterface) where

import Control.Concurrent (threadDelay)
import Data.Binary
import Data.ByteString.Lazy qualified as BSL
import Data.ByteString.Lazy.Internal qualified as BSL
import Relude hiding (ByteString, get, isPrefixOf, length, put, replicate)
import Saywayland.Events
import Saywayland.Requests
import Saywayland.Types
import Text.Printf

nextID :: IORef Word32 -> IO Word32
nextID counter = do
  current <- readIORef counter
  modifyIORef counter (+ 1)
  return current

findInterface :: Globals -> BSL.ByteString -> Maybe EventGlobal
findInterface globals targetInterface =
  let target = targetInterface <> "\0"
   in find (\(_, e) -> target `BSL.isPrefixOf` e.interface) globals >>= Just . snd

bindToInterface :: Word32 -> IORef Globals -> BSL.ByteString -> Wayland Word32
bindToInterface registryID globalsRef targetInterface =
  let go (count :: Int) = do
        when
          (count >= 10)
          (putStrLn ("ERROR: the wayland global " <> BSL.unpackChars targetInterface <> " not found") >> exitFailure)
        liftIO $ printf "Trying to bind to %s... (%i)\n" (BSL.unpackChars targetInterface) count
        env <- ask
        globals <- readIORef globalsRef
        case findInterface globals targetInterface of
          Nothing -> liftIO (threadDelay 100000) >> go (count + 1)
          Just e -> do
            newObjectID <- liftIO $ nextID env.counter
            wlRegistry_bind registryID e.name targetInterface e.version newObjectID
   in go 1
