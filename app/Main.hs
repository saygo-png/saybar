{- HLINT ignore "Use camelCase" -}

module Main (main) where

import Bar
import Codec.Picture (PixelRGBA8 (..))
import Codec.Picture.Types (Image)
import Config
import Control.Exception
import Data.Map qualified as Map
import Data.Set qualified as Set
import Foreign (nullPtr)
import GHC.Conc (orElse, retry)
import GHC.IO.Handle
import Generated.Fcft
import Generated.Fcft.Safe
import Manual.Fcft
import Modules
import Relude hiding (ByteString, get, isPrefixOf, put)
import RenderText (getGlyphs, renderGlyphs)
import Sayland
import System.Posix (ownerReadMode, ownerWriteMode, setFdSize, unionFileModes)
import System.Posix.IO
import System.Posix.SharedMem
import Types
import Utils

table :: ProtocolTable
table = ext_workspace_v1Table <> wlr_layer_shell_unstable_v1Table <> waylandTable <> xdg_shellTable

main :: IO ()
main = withWaylandClient table program

program :: Wayland Client ()
program = do
  ClientEnv env <- ask

  outputs :: TVar (Set GlobalName) <- newTVarIO mempty
  closed :: TVar Bool <- newTVarIO False

  onEventDo $ \_ -> \case
    Event_wl_registry_global name iface _ | iface == getInterfaceName (Proxy @Wl_output) -> atomically $ modifyTVar' outputs (Set.insert name)
    Event_wl_registry_global_remove name -> atomically $ modifyTVar' outputs (Set.delete name)
    _ -> pass

  wlDisplay <- getWlDisplay
  registry <- newObject wlDisplay Request_wl_display_get_registry

  -- `pendingRef` accumulates event-by-event within a batch.
  -- `committed` is only updated on `done` and is what gets rendered.
  -- This means the render loop always sees a consistent snapshot (is atomic).
  pendingRef :: IORef WorkspaceMap <- newIORef mempty
  committed :: TVar WorkspaceMap <- newTVarIO mempty
  workspacesVar :: TVar [Workspace] <- newTVarIO mempty -- live workspace list
  wakeUp :: TMVar () <- newEmptyTMVarIO
  serial :: TMVar Word32 <- newEmptyTMVarIO
  freeBuffer :: TMVar () <- newEmptyTMVarIO

  putStrLn "Binding to required interfaces..."

  roundtrip

  wlShm <- bindToInterface registry
  wlCompositor <- bindToInterface registry
  layerShell <- bindToInterface registry

  onEventDo $ \_ -> \case
    Event_ext_workspace_manager_v1_done -> do
      pending <- readIORef pendingRef
      let resolved = resolveWorkspaces pending
      atomically $ do
        writeTVar committed pending
        forM_ resolved $ writeTVar workspacesVar
        void $ tryPutTMVar wakeUp ()
    _ -> pass

  onEventDo $ \oid ev ->
    modifyIORef pendingRef $ \pending -> workspaceEventsHandler pending (fromAnyObjectID oid) ev

  _ext_workspace_manager_V1ID <- bindToInterface @Ext_workspace_manager_v1 registry

  onEventDo $ \_ -> \case
    (Event_zwlr_layer_surface_v1_configure s _ _) ->
      atomically $ tryTakeTMVar serial >> putTMVar serial s
    Event_zwlr_layer_surface_v1_closed -> atomically $ writeTVar closed True

  onEventDo $ \_ -> \case
    Event_wl_buffer_release ->
      atomically . void $ tryTakeTMVar freeBuffer

  let modules = makeModules workspacesVar
  startModules (rights modules) wakeUp

  let createBar = do
        wlSurfaceID <- newObject wlCompositor Request_wl_compositor_create_surface
        layerSurfaceID <- newObject layerShell $ \wlid ->
          Request_zwlr_layer_shell_v1_get_layer_surface wlid wlSurfaceID.wlid Nothing Enum_zwlr_layer_shell_v1_layer_top "saybar"

        sendMsg layerSurfaceID
          $ Request_zwlr_layer_surface_v1_set_anchor
            Enum_zwlr_layer_surface_v1_anchor
              { anchor_top = True
              , anchor_bottom = False
              , anchor_left = True
              , anchor_right = True
              }
        sendMsg layerSurfaceID $ Request_zwlr_layer_surface_v1_set_size 0 bufferHeight
        sendMsg layerSurfaceID $ Request_zwlr_layer_surface_v1_set_exclusive_zone (fi bufferHeight)

        atomically $ writeTVar closed False >> void (tryTakeTMVar serial) >> void (tryTakeTMVar freeBuffer)
        sendMsg wlSurfaceID Request_wl_surface_commit
        pure (wlSurfaceID, layerSurfaceID)

      untilClosed :: STM a -> Wayland Client (Maybe a)
      untilClosed act = atomically $ (Nothing <$ (readTVar closed >>= (`unless` retry))) `orElse` (Just <$> act)

  _ <- liftIO $ fcft_init FCFT_LOG_COLORIZE_AUTO 0 FCFT_LOG_CLASS_DEBUG
  font <- liftIO $ fcft_from_name2 ["monospace:size=14"] Nothing nullPtr

  textRun <- liftIO $ getGlyphs font " "
  (_, gap) <- liftIO $ renderGlyphs font textRun (PixelRGBA8 0 0 0 0) 0 0

  let ctx =
        RenderCtx
          { font = font
          , fontSize = 11
          , moduleGap = gap
          , drawColor = PixelRGBA8 213 196 161 255 -- #d5c4a1
          }

  let makeSharedMemoryObject = shmOpen poolName (ShmOpenFlags True True False True) (Relude.foldl' unionFileModes ownerWriteMode [ownerReadMode])
      removeSharedMemoryObject _ = shmUnlink poolName
      useSharedMemoryObject fileDescriptor =
        flip runReaderT (ClientEnv env) $ do
          let frameSize = bufferWidth * bufferHeight * colorChannels
          let poolSize = 2 * frameSize -- 2x for double buffering
          liftIO . setFdSize fileDescriptor $ fi poolSize
          wlShmPool <- newObject wlShm $ \wlid -> Request_wl_shm_create_pool wlid fileDescriptor (fi poolSize)

          let stride = bufferWidth * colorChannels
              mkBuffer offset = do
                buffer <- newObject wlShmPool $ \wlid ->
                  Request_wl_shm_pool_create_buffer wlid (fi offset) (fi bufferWidth) (fi bufferHeight) (fi stride) Enum_wl_shm_format_argb8888
                pure (buffer, offset)

          bufferA <- mkBuffer 0
          bufferB <- mkBuffer frameSize

          fileHandle <- liftIO $ fdToHandle fileDescriptor

          let renderLoop :: Wl_surface -> Zwlr_layer_surface_v1 -> ((Wl_buffer, Word32), (Wl_buffer, Word32)) -> Wayland Client ()
              renderLoop wlSurfaceID layerSurfaceID buffers = whenJustM (untilClosed $ takeTMVar wakeUp) $ \() -> do
                image <- liftIO $ renderBar ctx modules
                atomically (tryTakeTMVar serial) >>= traverse_ (sendMsg layerSurfaceID . Request_zwlr_layer_surface_v1_ack_configure)
                putImage wlSurfaceID fileHandle image (fst buffers)
                putTextLn "rerender!!!"
                whenJustM (untilClosed $ putTMVar freeBuffer ()) $ \() -> renderLoop wlSurfaceID layerSurfaceID (swap buffers)

              barLoop previous = do
                current <- atomically $ do
                  current <- readTVar outputs
                  when (Set.null current || Just current == previous) retry
                  pure current
                (wlSurfaceID, layerSurfaceID) <- createBar
                whenJustM (untilClosed $ takeTMVar serial) $ \s -> do
                  sendMsg layerSurfaceID $ Request_zwlr_layer_surface_v1_ack_configure s
                  atomically . void $ tryPutTMVar wakeUp ()
                  renderLoop wlSurfaceID layerSurfaceID (bufferA, bufferB)
                sendMsg layerSurfaceID Request_zwlr_layer_surface_v1_destroy
                sendMsg wlSurfaceID Request_wl_surface_destroy
                barLoop (Just current)

          barLoop Nothing

  liftIO . void $ bracket makeSharedMemoryObject removeSharedMemoryObject useSharedMemoryObject
  where
    putImage :: Wl_surface -> Handle -> Image PixelRGBA8 -> (Wl_buffer, Word32) -> Wayland Client ()
    putImage wlSurface fileHandle image (buffer, offset) = do
      liftIO . hSeek fileHandle AbsoluteSeek $ fi offset
      liftIO $ writeSwizzledRGBAtoBGRA fileHandle image
      sendMsg wlSurface $ Request_wl_surface_damage_buffer 0 0 (fi bufferWidth) (fi bufferHeight)
      sendMsg wlSurface $ Request_wl_surface_attach (Just buffer.wlid) 0 0
      sendMsg wlSurface Request_wl_surface_commit

    -- \| Promote a WorkspaceMap to a clean sorted [Workspace].
    --   Returns Nothing if any workspace is still missing fields.
    resolveWorkspaces :: WorkspaceMap -> Maybe [Workspace]
    resolveWorkspaces m =
      sortOn (.wsCoordinates) <$> traverse promote (Map.elems m)
      where
        promote (PendingWorkspace (Just n) (Just c) (Just s)) = Just (Workspace n c s)
        promote _ = Nothing
