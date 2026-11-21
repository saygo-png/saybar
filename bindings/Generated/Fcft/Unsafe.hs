{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_HADDOCK prune #-}

module Generated.Fcft.Unsafe
    ( Generated.Fcft.Unsafe.fcft_init
    , Generated.Fcft.Unsafe.fcft_fini
    , Generated.Fcft.Unsafe.fcft_capabilities
    , Generated.Fcft.Unsafe.fcft_clone
    , Generated.Fcft.Unsafe.fcft_destroy
    , Generated.Fcft.Unsafe.fcft_rasterize_char_utf32
    , Generated.Fcft.Unsafe.fcft_text_run_destroy
    , Generated.Fcft.Unsafe.fcft_kerning
    , Generated.Fcft.Unsafe.fcft_precompose
    , Generated.Fcft.Unsafe.fcft_font_options_create
    , Generated.Fcft.Unsafe.fcft_font_options_destroy
    )
  where

import qualified HsBindgen.Runtime.LibC
import qualified HsBindgen.Runtime.PtrConst as PtrConst
import qualified HsBindgen.Runtime.Support as BG
import qualified HsBindgen.Runtime.Support.CAPI
import Generated.Fcft
import Prelude (IO, fmap)

$(HsBindgen.Runtime.Support.CAPI.addCSource (HsBindgen.Runtime.Support.CAPI.unlines
  [ "#include <fcft/fcft.h>"
  , "_Bool hs_bindgen_fa1224be4b25632f ("
  , "  enum fcft_log_colorize arg1,"
  , "  _Bool arg2,"
  , "  enum fcft_log_class arg3"
  , ")"
  , "{"
  , "  return (fcft_init)(arg1, arg2, arg3);"
  , "}"
  , "void hs_bindgen_69c4bb20db51ee83 (void)"
  , "{"
  , "  (fcft_fini)();"
  , "}"
  , "enum fcft_capabilities hs_bindgen_6a4c43aab094d0d4 (void)"
  , "{"
  , "  return (fcft_capabilities)();"
  , "}"
  , "struct fcft_font *hs_bindgen_b067eb5bd062f407 ("
  , "  struct fcft_font const *arg1"
  , ")"
  , "{"
  , "  return (fcft_clone)(arg1);"
  , "}"
  , "void hs_bindgen_a0590b2acd888cfd ("
  , "  struct fcft_font *arg1"
  , ")"
  , "{"
  , "  (fcft_destroy)(arg1);"
  , "}"
  , "struct fcft_glyph const *hs_bindgen_0706c4ff0243df35 ("
  , "  struct fcft_font *arg1,"
  , "  uint32_t arg2,"
  , "  enum fcft_subpixel arg3"
  , ")"
  , "{"
  , "  return (fcft_rasterize_char_utf32)(arg1, arg2, arg3);"
  , "}"
  , "void hs_bindgen_0cac57f912c48691 ("
  , "  struct fcft_text_run *arg1"
  , ")"
  , "{"
  , "  (fcft_text_run_destroy)(arg1);"
  , "}"
  , "_Bool hs_bindgen_cf920e20ff93f95c ("
  , "  struct fcft_font *arg1,"
  , "  uint32_t arg2,"
  , "  uint32_t arg3,"
  , "  signed long *arg4,"
  , "  signed long *arg5"
  , ")"
  , "{"
  , "  return (fcft_kerning)(arg1, arg2, arg3, arg4, arg5);"
  , "}"
  , "uint32_t hs_bindgen_8009f0fea2a2778b ("
  , "  struct fcft_font const *arg1,"
  , "  uint32_t arg2,"
  , "  uint32_t arg3,"
  , "  _Bool *arg4,"
  , "  _Bool *arg5,"
  , "  _Bool *arg6"
  , ")"
  , "{"
  , "  return (fcft_precompose)(arg1, arg2, arg3, arg4, arg5, arg6);"
  , "}"
  , "struct fcft_font_options *hs_bindgen_af5839fd8c52d32e (void)"
  , "{"
  , "  return (fcft_font_options_create)();"
  , "}"
  , "void hs_bindgen_78a5d8ab576a564d ("
  , "  struct fcft_font_options *arg1"
  , ")"
  , "{"
  , "  (fcft_font_options_destroy)(arg1);"
  , "}"
  ]))

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_init@
foreign import ccall unsafe "hs_bindgen_fa1224be4b25632f" hs_bindgen_fa1224be4b25632f_base ::
     BG.CUInt
  -> BG.CBool
  -> BG.CUInt
  -> IO BG.CBool

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_init@
hs_bindgen_fa1224be4b25632f ::
     Fcft_log_colorize
  -> BG.CBool
  -> Fcft_log_class
  -> IO BG.CBool
hs_bindgen_fa1224be4b25632f =
  \x0 ->
    \x1 ->
      \x2 ->
        fmap BG.fromFFIType (hs_bindgen_fa1224be4b25632f_base (BG.toFFIType x0) (BG.toFFIType x1) (BG.toFFIType x2))

{-| __C declaration:__ @fcft_init@

    __defined at:__ @fcft\/fcft.h 35:6@

    __exported by:__ @fcft\/fcft.h@
-}
fcft_init ::
     Fcft_log_colorize
     -- ^ __C declaration:__ @colorize@
  -> BG.CBool
     -- ^ __C declaration:__ @do_syslog@
  -> Fcft_log_class
     -- ^ __C declaration:__ @log_level@
  -> IO BG.CBool
fcft_init = hs_bindgen_fa1224be4b25632f

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_fini@
foreign import ccall unsafe "hs_bindgen_69c4bb20db51ee83" hs_bindgen_69c4bb20db51ee83_base ::
     IO ()

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_fini@
hs_bindgen_69c4bb20db51ee83 :: IO ()
hs_bindgen_69c4bb20db51ee83 =
  hs_bindgen_69c4bb20db51ee83_base

{-| __C declaration:__ @fcft_fini@

    __defined at:__ @fcft\/fcft.h 39:6@

    __exported by:__ @fcft\/fcft.h@
-}
fcft_fini :: IO ()
fcft_fini = hs_bindgen_69c4bb20db51ee83

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_capabilities@
foreign import ccall unsafe "hs_bindgen_6a4c43aab094d0d4" hs_bindgen_6a4c43aab094d0d4_base ::
     IO BG.CUInt

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_capabilities@
hs_bindgen_6a4c43aab094d0d4 :: IO Fcft_capabilities
hs_bindgen_6a4c43aab094d0d4 =
  fmap BG.fromFFIType hs_bindgen_6a4c43aab094d0d4_base

{-| __C declaration:__ @fcft_capabilities@

    __defined at:__ @fcft\/fcft.h 93:24@

    __exported by:__ @fcft\/fcft.h@
-}
fcft_capabilities :: IO Fcft_capabilities
fcft_capabilities = hs_bindgen_6a4c43aab094d0d4

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_clone@
foreign import ccall unsafe "hs_bindgen_b067eb5bd062f407" hs_bindgen_b067eb5bd062f407_base ::
     BG.Ptr BG.Void
  -> IO (BG.Ptr BG.Void)

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_clone@
hs_bindgen_b067eb5bd062f407 ::
     PtrConst.PtrConst Fcft_font
  -> IO (BG.Ptr Fcft_font)
hs_bindgen_b067eb5bd062f407 =
  \x0 ->
    fmap BG.fromFFIType (hs_bindgen_b067eb5bd062f407_base (BG.toFFIType x0))

{-| __C declaration:__ @fcft_clone@

    __defined at:__ @fcft\/fcft.h 99:19@

    __exported by:__ @fcft\/fcft.h@
-}
fcft_clone ::
     PtrConst.PtrConst Fcft_font
     -- ^ __C declaration:__ @font@
  -> IO (BG.Ptr Fcft_font)
fcft_clone = hs_bindgen_b067eb5bd062f407

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_destroy@
foreign import ccall unsafe "hs_bindgen_a0590b2acd888cfd" hs_bindgen_a0590b2acd888cfd_base ::
     BG.Ptr BG.Void
  -> IO ()

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_destroy@
hs_bindgen_a0590b2acd888cfd ::
     BG.Ptr Fcft_font
  -> IO ()
hs_bindgen_a0590b2acd888cfd =
  \x0 ->
    hs_bindgen_a0590b2acd888cfd_base (BG.toFFIType x0)

{-| __C declaration:__ @fcft_destroy@

    __defined at:__ @fcft\/fcft.h 100:6@

    __exported by:__ @fcft\/fcft.h@
-}
fcft_destroy ::
     BG.Ptr Fcft_font
     -- ^ __C declaration:__ @font@
  -> IO ()
fcft_destroy = hs_bindgen_a0590b2acd888cfd

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_rasterize_char_utf32@
foreign import ccall unsafe "hs_bindgen_0706c4ff0243df35" hs_bindgen_0706c4ff0243df35_base ::
     BG.Ptr BG.Void
  -> HsBindgen.Runtime.LibC.Word32
  -> BG.CUInt
  -> IO (BG.Ptr BG.Void)

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_rasterize_char_utf32@
hs_bindgen_0706c4ff0243df35 ::
     BG.Ptr Fcft_font
  -> HsBindgen.Runtime.LibC.Word32
  -> Fcft_subpixel
  -> IO (PtrConst.PtrConst Fcft_glyph)
hs_bindgen_0706c4ff0243df35 =
  \x0 ->
    \x1 ->
      \x2 ->
        fmap BG.fromFFIType (hs_bindgen_0706c4ff0243df35_base (BG.toFFIType x0) (BG.toFFIType x1) (BG.toFFIType x2))

{-| __C declaration:__ @fcft_rasterize_char_utf32@

    __defined at:__ @fcft\/fcft.h 124:26@

    __exported by:__ @fcft\/fcft.h@
-}
fcft_rasterize_char_utf32 ::
     BG.Ptr Fcft_font
     -- ^ __C declaration:__ @font@
  -> HsBindgen.Runtime.LibC.Word32
     -- ^ __C declaration:__ @cp@
  -> Fcft_subpixel
     -- ^ __C declaration:__ @subpixel@
  -> IO (PtrConst.PtrConst Fcft_glyph)
fcft_rasterize_char_utf32 =
  hs_bindgen_0706c4ff0243df35

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_text_run_destroy@
foreign import ccall unsafe "hs_bindgen_0cac57f912c48691" hs_bindgen_0cac57f912c48691_base ::
     BG.Ptr BG.Void
  -> IO ()

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_text_run_destroy@
hs_bindgen_0cac57f912c48691 ::
     BG.Ptr Fcft_text_run
  -> IO ()
hs_bindgen_0cac57f912c48691 =
  \x0 ->
    hs_bindgen_0cac57f912c48691_base (BG.toFFIType x0)

{-| __C declaration:__ @fcft_text_run_destroy@

    __defined at:__ @fcft\/fcft.h 149:6@

    __exported by:__ @fcft\/fcft.h@
-}
fcft_text_run_destroy ::
     BG.Ptr Fcft_text_run
     -- ^ __C declaration:__ @run@
  -> IO ()
fcft_text_run_destroy = hs_bindgen_0cac57f912c48691

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_kerning@
foreign import ccall unsafe "hs_bindgen_cf920e20ff93f95c" hs_bindgen_cf920e20ff93f95c_base ::
     BG.Ptr BG.Void
  -> HsBindgen.Runtime.LibC.Word32
  -> HsBindgen.Runtime.LibC.Word32
  -> BG.Ptr BG.Void
  -> BG.Ptr BG.Void
  -> IO BG.CBool

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_kerning@
hs_bindgen_cf920e20ff93f95c ::
     BG.Ptr Fcft_font
  -> HsBindgen.Runtime.LibC.Word32
  -> HsBindgen.Runtime.LibC.Word32
  -> BG.Ptr BG.CLong
  -> BG.Ptr BG.CLong
  -> IO BG.CBool
hs_bindgen_cf920e20ff93f95c =
  \x0 ->
    \x1 ->
      \x2 ->
        \x3 ->
          \x4 ->
            fmap BG.fromFFIType (hs_bindgen_cf920e20ff93f95c_base (BG.toFFIType x0) (BG.toFFIType x1) (BG.toFFIType x2) (BG.toFFIType x3) (BG.toFFIType x4))

{-| __C declaration:__ @fcft_kerning@

    __defined at:__ @fcft\/fcft.h 151:6@

    __exported by:__ @fcft\/fcft.h@
-}
fcft_kerning ::
     BG.Ptr Fcft_font
     -- ^ __C declaration:__ @font@
  -> HsBindgen.Runtime.LibC.Word32
     -- ^ __C declaration:__ @left@
  -> HsBindgen.Runtime.LibC.Word32
     -- ^ __C declaration:__ @right@
  -> BG.Ptr BG.CLong
     -- ^ __C declaration:__ @x@
  -> BG.Ptr BG.CLong
     -- ^ __C declaration:__ @y@
  -> IO BG.CBool
fcft_kerning = hs_bindgen_cf920e20ff93f95c

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_precompose@
foreign import ccall unsafe "hs_bindgen_8009f0fea2a2778b" hs_bindgen_8009f0fea2a2778b_base ::
     BG.Ptr BG.Void
  -> HsBindgen.Runtime.LibC.Word32
  -> HsBindgen.Runtime.LibC.Word32
  -> BG.Ptr BG.Void
  -> BG.Ptr BG.Void
  -> BG.Ptr BG.Void
  -> IO HsBindgen.Runtime.LibC.Word32

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_precompose@
hs_bindgen_8009f0fea2a2778b ::
     PtrConst.PtrConst Fcft_font
  -> HsBindgen.Runtime.LibC.Word32
  -> HsBindgen.Runtime.LibC.Word32
  -> BG.Ptr BG.CBool
  -> BG.Ptr BG.CBool
  -> BG.Ptr BG.CBool
  -> IO HsBindgen.Runtime.LibC.Word32
hs_bindgen_8009f0fea2a2778b =
  \x0 ->
    \x1 ->
      \x2 ->
        \x3 ->
          \x4 ->
            \x5 ->
              fmap BG.fromFFIType (hs_bindgen_8009f0fea2a2778b_base (BG.toFFIType x0) (BG.toFFIType x1) (BG.toFFIType x2) (BG.toFFIType x3) (BG.toFFIType x4) (BG.toFFIType x5))

{-| __C declaration:__ @fcft_precompose@

    __defined at:__ @fcft\/fcft.h 155:10@

    __exported by:__ @fcft\/fcft.h@
-}
fcft_precompose ::
     PtrConst.PtrConst Fcft_font
     -- ^ __C declaration:__ @font@
  -> HsBindgen.Runtime.LibC.Word32
     -- ^ __C declaration:__ @base@
  -> HsBindgen.Runtime.LibC.Word32
     -- ^ __C declaration:__ @comb@
  -> BG.Ptr BG.CBool
     -- ^ __C declaration:__ @base_is_from_primary@
  -> BG.Ptr BG.CBool
     -- ^ __C declaration:__ @comb_is_from_primary@
  -> BG.Ptr BG.CBool
     -- ^ __C declaration:__ @composed_is_from_primary@
  -> IO HsBindgen.Runtime.LibC.Word32
fcft_precompose = hs_bindgen_8009f0fea2a2778b

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_font_options_create@
foreign import ccall unsafe "hs_bindgen_af5839fd8c52d32e" hs_bindgen_af5839fd8c52d32e_base ::
     IO (BG.Ptr BG.Void)

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_font_options_create@
hs_bindgen_af5839fd8c52d32e :: IO (BG.Ptr Fcft_font_options)
hs_bindgen_af5839fd8c52d32e =
  fmap BG.fromFFIType hs_bindgen_af5839fd8c52d32e_base

{-| __C declaration:__ @fcft_font_options_create@

    __defined at:__ @fcft\/fcft.h 234:27@

    __exported by:__ @fcft\/fcft.h@
-}
fcft_font_options_create :: IO (BG.Ptr Fcft_font_options)
fcft_font_options_create =
  hs_bindgen_af5839fd8c52d32e

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_font_options_destroy@
foreign import ccall unsafe "hs_bindgen_78a5d8ab576a564d" hs_bindgen_78a5d8ab576a564d_base ::
     BG.Ptr BG.Void
  -> IO ()

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_font_options_destroy@
hs_bindgen_78a5d8ab576a564d ::
     BG.Ptr Fcft_font_options
  -> IO ()
hs_bindgen_78a5d8ab576a564d =
  \x0 ->
    hs_bindgen_78a5d8ab576a564d_base (BG.toFFIType x0)

{-| __C declaration:__ @fcft_font_options_destroy@

    __defined at:__ @fcft\/fcft.h 235:6@

    __exported by:__ @fcft\/fcft.h@
-}
fcft_font_options_destroy ::
     BG.Ptr Fcft_font_options
     -- ^ __C declaration:__ @options@
  -> IO ()
fcft_font_options_destroy =
  hs_bindgen_78a5d8ab576a564d
