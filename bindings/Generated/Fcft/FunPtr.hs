{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_HADDOCK prune #-}

module Generated.Fcft.FunPtr
    ( Generated.Fcft.FunPtr.fcft_init
    , Generated.Fcft.FunPtr.fcft_fini
    , Generated.Fcft.FunPtr.fcft_capabilities
    , Generated.Fcft.FunPtr.fcft_clone
    , Generated.Fcft.FunPtr.fcft_destroy
    , Generated.Fcft.FunPtr.fcft_rasterize_char_utf32
    , Generated.Fcft.FunPtr.fcft_text_run_destroy
    , Generated.Fcft.FunPtr.fcft_kerning
    , Generated.Fcft.FunPtr.fcft_precompose
    , Generated.Fcft.FunPtr.fcft_font_options_create
    , Generated.Fcft.FunPtr.fcft_font_options_destroy
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
  , "/* saygo_bindings_fcft_Generated.Fcft_get_fcft_init */"
  , "__attribute__ ((const))"
  , "_Bool (*hs_bindgen_d91f0ad496c51ffc (void)) ("
  , "  enum fcft_log_colorize arg1,"
  , "  _Bool arg2,"
  , "  enum fcft_log_class arg3"
  , ")"
  , "{"
  , "  return &fcft_init;"
  , "}"
  , "/* saygo_bindings_fcft_Generated.Fcft_get_fcft_fini */"
  , "__attribute__ ((const))"
  , "void (*hs_bindgen_71b897e3d8688cc2 (void)) (void)"
  , "{"
  , "  return &fcft_fini;"
  , "}"
  , "/* saygo_bindings_fcft_Generated.Fcft_get_fcft_capabilities */"
  , "__attribute__ ((const))"
  , "enum fcft_capabilities (*hs_bindgen_eba472cd4dc3c50a (void)) (void)"
  , "{"
  , "  return &fcft_capabilities;"
  , "}"
  , "/* saygo_bindings_fcft_Generated.Fcft_get_fcft_clone */"
  , "__attribute__ ((const))"
  , "struct fcft_font *(*hs_bindgen_1374a19f81956d44 (void)) ("
  , "  struct fcft_font const *arg1"
  , ")"
  , "{"
  , "  return &fcft_clone;"
  , "}"
  , "/* saygo_bindings_fcft_Generated.Fcft_get_fcft_destroy */"
  , "__attribute__ ((const))"
  , "void (*hs_bindgen_854f9510b252c808 (void)) ("
  , "  struct fcft_font *arg1"
  , ")"
  , "{"
  , "  return &fcft_destroy;"
  , "}"
  , "/* saygo_bindings_fcft_Generated.Fcft_get_fcft_rasterize_char_utf32 */"
  , "__attribute__ ((const))"
  , "struct fcft_glyph const *(*hs_bindgen_489ed2a2baeceffe (void)) ("
  , "  struct fcft_font *arg1,"
  , "  uint32_t arg2,"
  , "  enum fcft_subpixel arg3"
  , ")"
  , "{"
  , "  return &fcft_rasterize_char_utf32;"
  , "}"
  , "/* saygo_bindings_fcft_Generated.Fcft_get_fcft_text_run_destroy */"
  , "__attribute__ ((const))"
  , "void (*hs_bindgen_05ef6b71f9929561 (void)) ("
  , "  struct fcft_text_run *arg1"
  , ")"
  , "{"
  , "  return &fcft_text_run_destroy;"
  , "}"
  , "/* saygo_bindings_fcft_Generated.Fcft_get_fcft_kerning */"
  , "__attribute__ ((const))"
  , "_Bool (*hs_bindgen_ad6a0fffa0acf165 (void)) ("
  , "  struct fcft_font *arg1,"
  , "  uint32_t arg2,"
  , "  uint32_t arg3,"
  , "  signed long *arg4,"
  , "  signed long *arg5"
  , ")"
  , "{"
  , "  return &fcft_kerning;"
  , "}"
  , "/* saygo_bindings_fcft_Generated.Fcft_get_fcft_precompose */"
  , "__attribute__ ((const))"
  , "uint32_t (*hs_bindgen_3fb59af06d62e5b3 (void)) ("
  , "  struct fcft_font const *arg1,"
  , "  uint32_t arg2,"
  , "  uint32_t arg3,"
  , "  _Bool *arg4,"
  , "  _Bool *arg5,"
  , "  _Bool *arg6"
  , ")"
  , "{"
  , "  return &fcft_precompose;"
  , "}"
  , "/* saygo_bindings_fcft_Generated.Fcft_get_fcft_font_options_create */"
  , "__attribute__ ((const))"
  , "struct fcft_font_options *(*hs_bindgen_1771aa3a08508c4a (void)) (void)"
  , "{"
  , "  return &fcft_font_options_create;"
  , "}"
  , "/* saygo_bindings_fcft_Generated.Fcft_get_fcft_font_options_destroy */"
  , "__attribute__ ((const))"
  , "void (*hs_bindgen_77e951988e97326f (void)) ("
  , "  struct fcft_font_options *arg1"
  , ")"
  , "{"
  , "  return &fcft_font_options_destroy;"
  , "}"
  ]))

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_init@
foreign import ccall unsafe "hs_bindgen_d91f0ad496c51ffc" hs_bindgen_d91f0ad496c51ffc_base ::
     IO (BG.FunPtr BG.Void)

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_init@
hs_bindgen_d91f0ad496c51ffc :: IO (BG.FunPtr (Fcft_log_colorize -> BG.CBool -> Fcft_log_class -> IO BG.CBool))
hs_bindgen_d91f0ad496c51ffc =
  fmap BG.fromFFIType hs_bindgen_d91f0ad496c51ffc_base

{-# NOINLINE fcft_init #-}
{-| __C declaration:__ @fcft_init@

    __defined at:__ @fcft\/fcft.h 35:6@

    __exported by:__ @fcft\/fcft.h@
-}
fcft_init :: BG.FunPtr (Fcft_log_colorize -> BG.CBool -> Fcft_log_class -> IO BG.CBool)
fcft_init =
  BG.unsafePerformIO hs_bindgen_d91f0ad496c51ffc

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_fini@
foreign import ccall unsafe "hs_bindgen_71b897e3d8688cc2" hs_bindgen_71b897e3d8688cc2_base ::
     IO (BG.FunPtr BG.Void)

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_fini@
hs_bindgen_71b897e3d8688cc2 :: IO (BG.FunPtr (IO ()))
hs_bindgen_71b897e3d8688cc2 =
  fmap BG.fromFFIType hs_bindgen_71b897e3d8688cc2_base

{-# NOINLINE fcft_fini #-}
{-| __C declaration:__ @fcft_fini@

    __defined at:__ @fcft\/fcft.h 39:6@

    __exported by:__ @fcft\/fcft.h@
-}
fcft_fini :: BG.FunPtr (IO ())
fcft_fini =
  BG.unsafePerformIO hs_bindgen_71b897e3d8688cc2

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_capabilities@
foreign import ccall unsafe "hs_bindgen_eba472cd4dc3c50a" hs_bindgen_eba472cd4dc3c50a_base ::
     IO (BG.FunPtr BG.Void)

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_capabilities@
hs_bindgen_eba472cd4dc3c50a :: IO (BG.FunPtr (IO Fcft_capabilities))
hs_bindgen_eba472cd4dc3c50a =
  fmap BG.fromFFIType hs_bindgen_eba472cd4dc3c50a_base

{-# NOINLINE fcft_capabilities #-}
{-| __C declaration:__ @fcft_capabilities@

    __defined at:__ @fcft\/fcft.h 93:24@

    __exported by:__ @fcft\/fcft.h@
-}
fcft_capabilities :: BG.FunPtr (IO Fcft_capabilities)
fcft_capabilities =
  BG.unsafePerformIO hs_bindgen_eba472cd4dc3c50a

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_clone@
foreign import ccall unsafe "hs_bindgen_1374a19f81956d44" hs_bindgen_1374a19f81956d44_base ::
     IO (BG.FunPtr BG.Void)

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_clone@
hs_bindgen_1374a19f81956d44 :: IO (BG.FunPtr (PtrConst.PtrConst Fcft_font -> IO (BG.Ptr Fcft_font)))
hs_bindgen_1374a19f81956d44 =
  fmap BG.fromFFIType hs_bindgen_1374a19f81956d44_base

{-# NOINLINE fcft_clone #-}
{-| __C declaration:__ @fcft_clone@

    __defined at:__ @fcft\/fcft.h 99:19@

    __exported by:__ @fcft\/fcft.h@
-}
fcft_clone :: BG.FunPtr (PtrConst.PtrConst Fcft_font -> IO (BG.Ptr Fcft_font))
fcft_clone =
  BG.unsafePerformIO hs_bindgen_1374a19f81956d44

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_destroy@
foreign import ccall unsafe "hs_bindgen_854f9510b252c808" hs_bindgen_854f9510b252c808_base ::
     IO (BG.FunPtr BG.Void)

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_destroy@
hs_bindgen_854f9510b252c808 :: IO (BG.FunPtr (BG.Ptr Fcft_font -> IO ()))
hs_bindgen_854f9510b252c808 =
  fmap BG.fromFFIType hs_bindgen_854f9510b252c808_base

{-# NOINLINE fcft_destroy #-}
{-| __C declaration:__ @fcft_destroy@

    __defined at:__ @fcft\/fcft.h 100:6@

    __exported by:__ @fcft\/fcft.h@
-}
fcft_destroy :: BG.FunPtr (BG.Ptr Fcft_font -> IO ())
fcft_destroy =
  BG.unsafePerformIO hs_bindgen_854f9510b252c808

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_rasterize_char_utf32@
foreign import ccall unsafe "hs_bindgen_489ed2a2baeceffe" hs_bindgen_489ed2a2baeceffe_base ::
     IO (BG.FunPtr BG.Void)

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_rasterize_char_utf32@
hs_bindgen_489ed2a2baeceffe :: IO (BG.FunPtr (BG.Ptr Fcft_font -> HsBindgen.Runtime.LibC.Word32 -> Fcft_subpixel -> IO (PtrConst.PtrConst Fcft_glyph)))
hs_bindgen_489ed2a2baeceffe =
  fmap BG.fromFFIType hs_bindgen_489ed2a2baeceffe_base

{-# NOINLINE fcft_rasterize_char_utf32 #-}
{-| __C declaration:__ @fcft_rasterize_char_utf32@

    __defined at:__ @fcft\/fcft.h 124:26@

    __exported by:__ @fcft\/fcft.h@
-}
fcft_rasterize_char_utf32 :: BG.FunPtr (BG.Ptr Fcft_font -> HsBindgen.Runtime.LibC.Word32 -> Fcft_subpixel -> IO (PtrConst.PtrConst Fcft_glyph))
fcft_rasterize_char_utf32 =
  BG.unsafePerformIO hs_bindgen_489ed2a2baeceffe

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_text_run_destroy@
foreign import ccall unsafe "hs_bindgen_05ef6b71f9929561" hs_bindgen_05ef6b71f9929561_base ::
     IO (BG.FunPtr BG.Void)

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_text_run_destroy@
hs_bindgen_05ef6b71f9929561 :: IO (BG.FunPtr (BG.Ptr Fcft_text_run -> IO ()))
hs_bindgen_05ef6b71f9929561 =
  fmap BG.fromFFIType hs_bindgen_05ef6b71f9929561_base

{-# NOINLINE fcft_text_run_destroy #-}
{-| __C declaration:__ @fcft_text_run_destroy@

    __defined at:__ @fcft\/fcft.h 149:6@

    __exported by:__ @fcft\/fcft.h@
-}
fcft_text_run_destroy :: BG.FunPtr (BG.Ptr Fcft_text_run -> IO ())
fcft_text_run_destroy =
  BG.unsafePerformIO hs_bindgen_05ef6b71f9929561

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_kerning@
foreign import ccall unsafe "hs_bindgen_ad6a0fffa0acf165" hs_bindgen_ad6a0fffa0acf165_base ::
     IO (BG.FunPtr BG.Void)

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_kerning@
hs_bindgen_ad6a0fffa0acf165 :: IO (BG.FunPtr (BG.Ptr Fcft_font -> HsBindgen.Runtime.LibC.Word32 -> HsBindgen.Runtime.LibC.Word32 -> BG.Ptr BG.CLong -> BG.Ptr BG.CLong -> IO BG.CBool))
hs_bindgen_ad6a0fffa0acf165 =
  fmap BG.fromFFIType hs_bindgen_ad6a0fffa0acf165_base

{-# NOINLINE fcft_kerning #-}
{-| __C declaration:__ @fcft_kerning@

    __defined at:__ @fcft\/fcft.h 151:6@

    __exported by:__ @fcft\/fcft.h@
-}
fcft_kerning :: BG.FunPtr (BG.Ptr Fcft_font -> HsBindgen.Runtime.LibC.Word32 -> HsBindgen.Runtime.LibC.Word32 -> BG.Ptr BG.CLong -> BG.Ptr BG.CLong -> IO BG.CBool)
fcft_kerning =
  BG.unsafePerformIO hs_bindgen_ad6a0fffa0acf165

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_precompose@
foreign import ccall unsafe "hs_bindgen_3fb59af06d62e5b3" hs_bindgen_3fb59af06d62e5b3_base ::
     IO (BG.FunPtr BG.Void)

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_precompose@
hs_bindgen_3fb59af06d62e5b3 :: IO (BG.FunPtr (PtrConst.PtrConst Fcft_font -> HsBindgen.Runtime.LibC.Word32 -> HsBindgen.Runtime.LibC.Word32 -> BG.Ptr BG.CBool -> BG.Ptr BG.CBool -> BG.Ptr BG.CBool -> IO HsBindgen.Runtime.LibC.Word32))
hs_bindgen_3fb59af06d62e5b3 =
  fmap BG.fromFFIType hs_bindgen_3fb59af06d62e5b3_base

{-# NOINLINE fcft_precompose #-}
{-| __C declaration:__ @fcft_precompose@

    __defined at:__ @fcft\/fcft.h 155:10@

    __exported by:__ @fcft\/fcft.h@
-}
fcft_precompose :: BG.FunPtr (PtrConst.PtrConst Fcft_font -> HsBindgen.Runtime.LibC.Word32 -> HsBindgen.Runtime.LibC.Word32 -> BG.Ptr BG.CBool -> BG.Ptr BG.CBool -> BG.Ptr BG.CBool -> IO HsBindgen.Runtime.LibC.Word32)
fcft_precompose =
  BG.unsafePerformIO hs_bindgen_3fb59af06d62e5b3

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_font_options_create@
foreign import ccall unsafe "hs_bindgen_1771aa3a08508c4a" hs_bindgen_1771aa3a08508c4a_base ::
     IO (BG.FunPtr BG.Void)

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_font_options_create@
hs_bindgen_1771aa3a08508c4a :: IO (BG.FunPtr (IO (BG.Ptr Fcft_font_options)))
hs_bindgen_1771aa3a08508c4a =
  fmap BG.fromFFIType hs_bindgen_1771aa3a08508c4a_base

{-# NOINLINE fcft_font_options_create #-}
{-| __C declaration:__ @fcft_font_options_create@

    __defined at:__ @fcft\/fcft.h 234:27@

    __exported by:__ @fcft\/fcft.h@
-}
fcft_font_options_create :: BG.FunPtr (IO (BG.Ptr Fcft_font_options))
fcft_font_options_create =
  BG.unsafePerformIO hs_bindgen_1771aa3a08508c4a

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_font_options_destroy@
foreign import ccall unsafe "hs_bindgen_77e951988e97326f" hs_bindgen_77e951988e97326f_base ::
     IO (BG.FunPtr BG.Void)

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_font_options_destroy@
hs_bindgen_77e951988e97326f :: IO (BG.FunPtr (BG.Ptr Fcft_font_options -> IO ()))
hs_bindgen_77e951988e97326f =
  fmap BG.fromFFIType hs_bindgen_77e951988e97326f_base

{-# NOINLINE fcft_font_options_destroy #-}
{-| __C declaration:__ @fcft_font_options_destroy@

    __defined at:__ @fcft\/fcft.h 235:6@

    __exported by:__ @fcft\/fcft.h@
-}
fcft_font_options_destroy :: BG.FunPtr (BG.Ptr Fcft_font_options -> IO ())
fcft_font_options_destroy =
  BG.unsafePerformIO hs_bindgen_77e951988e97326f
