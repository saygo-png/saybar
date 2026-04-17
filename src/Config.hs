module Config (colorChannels, bufferWidth, bufferHeight, poolName, colorFormat, makeModules) where

import Modules
import Relude
import Types
import Saywayland.Types

bufferWidth :: WlUint
bufferWidth = 1920

bufferHeight :: WlUint
bufferHeight = 20

poolName :: String
poolName = "saybar-shared-pool"

colorFormat :: Word32
colorFormat = 0 -- ARGB8888

colorChannels :: WlUint
colorChannels = 4

{- | Build the ordered list of bar modules.
  Called once from Main after the workspace TVar is created.
  Add, remove, or reorder modules here.
-}
makeModules :: TVar [Workspace] -> [Either Spacer BarModule]
makeModules wsVar =
  [ Right $ workspaceModule wsVar
  , Left Spacer
  , Right dateModule
  ]
