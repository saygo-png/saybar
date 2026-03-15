{-# LANGUAGE CApiFFI #-}

module Manual.Fcft (
  fcft_from_name2,
  pixman_image_get_data,
  pixman_image_get_stride,
  fcft_rasterize_text_run_utf32,
) where

import Foreign
import Foreign.C.ConstPtr
import Foreign.C.String (CString, withCString)
import Foreign.C.Types
import Foreign.Marshal.Array (withArray)
import Generated.Fcft
import Generated.Fcft.Safe

foreign import capi safe "fcft/fcft.h fcft_from_name2"
  fcft_from_name2_raw ::
    CSize ->
    Ptr (ConstPtr CChar) -> -- const char **
    ConstPtr CChar -> -- const char *
    Ptr Fcft_font_options ->
    IO (Ptr Fcft_font)

fcft_from_name2 ::
  -- | font names
  [String] ->
  -- | attributes (Nothing = NULL)
  Maybe String ->
  -- | options (nullPtr for defaults)
  Ptr Fcft_font_options ->
  IO (Ptr Fcft_font)
fcft_from_name2 names mattrs options =
  withCStrings names $ \count cnames ->
    withMaybeCString mattrs $ \cattrs ->
      fcft_from_name2_raw (fromIntegral count) (castPtr cnames) (ConstPtr cattrs) options

foreign import capi safe "fcft/fcft.h fcft_rasterize_text_run_utf32"
  fcft_rasterize_text_run_utf32 ::
    Ptr Fcft_font ->
    CSize ->
    ConstPtr Word32 ->
    Fcft_subpixel ->
    IO (Ptr Fcft_text_run)

-- Pixman binds (needed to read glyph pixel data)
foreign import capi safe "pixman.h pixman_image_get_data"
  pixman_image_get_data :: Ptr Pixman_image_t -> IO (Ptr Word32)

foreign import capi safe "pixman.h pixman_image_get_stride"
  pixman_image_get_stride :: Ptr Pixman_image_t -> IO CInt

withCStrings :: [String] -> (Int -> Ptr CString -> IO a) -> IO a
withCStrings ss k = go ss [] $ \cs -> withArray cs (k (length cs))
  where
    go [] acc f = f (reverse acc)
    go (x : xs) acc f = withCString x $ \cs -> go xs (cs : acc) f

withMaybeCString :: Maybe String -> (CString -> IO a) -> IO a
withMaybeCString Nothing k = k nullPtr
withMaybeCString (Just s) k = withCString s k
