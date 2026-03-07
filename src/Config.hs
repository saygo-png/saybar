module Config (colorChannels, bufferWidth, bufferHeight, poolName, colorFormat) where

import Saywayland
import Relude

bufferWidth :: WlInt
bufferWidth = 1920

bufferHeight :: WlInt
bufferHeight = 20

poolName :: String
poolName = "saybar-shared-pool"

colorFormat :: Word32
colorFormat = 0 -- ARGB8888

colorChannels :: WlInt
colorChannels = 4
