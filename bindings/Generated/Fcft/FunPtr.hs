{-# LANGUAGE CApiFFI #-}
{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_HADDOCK prune #-}

module Generated.Fcft.FunPtr
    ( Generated.Fcft.FunPtr.fcft_init
    , Generated.Fcft.FunPtr.fcft_fini
    , Generated.Fcft.FunPtr.fcft_capabilities
    , Generated.Fcft.FunPtr.fcft_clone
    , Generated.Fcft.FunPtr.fcft_destroy
    , Generated.Fcft.FunPtr.fcft_kerning
    , Generated.Fcft.FunPtr.fcft_precompose
    )
  where

import qualified HsBindgen.Runtime.Internal.CAPI
import qualified HsBindgen.Runtime.Internal.Prelude as RIP
import qualified HsBindgen.Runtime.LibC
import qualified HsBindgen.Runtime.PtrConst as PtrConst
import Generated.Fcft

$(HsBindgen.Runtime.Internal.CAPI.addCSource (HsBindgen.Runtime.Internal.CAPI.unlines
  [ "#include </nix/store/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3/include/fcft/fcft.h>"
  , "/* saygo_bindings_fcft_Generated.Fcft_get_fcft_init */"
  , "__attribute__ ((const))"
  , "bool (*hs_bindgen_d91f0ad496c51ffc (void)) ("
  , "  enum fcft_log_colorize arg1,"
  , "  bool arg2,"
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
  , "/* saygo_bindings_fcft_Generated.Fcft_get_fcft_kerning */"
  , "__attribute__ ((const))"
  , "bool (*hs_bindgen_ad6a0fffa0acf165 (void)) ("
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
  , "  bool *arg4,"
  , "  bool *arg5,"
  , "  bool *arg6"
  , ")"
  , "{"
  , "  return &fcft_precompose;"
  , "}"
  ]))

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_init@
foreign import ccall unsafe "hs_bindgen_d91f0ad496c51ffc" hs_bindgen_d91f0ad496c51ffc_base ::
     IO (RIP.FunPtr RIP.Void)

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_init@
hs_bindgen_d91f0ad496c51ffc :: IO (RIP.FunPtr (Fcft_log_colorize -> HsBindgen.Runtime.LibC.CBool -> Fcft_log_class -> IO HsBindgen.Runtime.LibC.CBool))
hs_bindgen_d91f0ad496c51ffc =
  RIP.fromFFIType hs_bindgen_d91f0ad496c51ffc_base

{-# NOINLINE fcft_init #-}
{-| __C declaration:__ @fcft_init@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 35:6@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
fcft_init :: RIP.FunPtr (Fcft_log_colorize -> HsBindgen.Runtime.LibC.CBool -> Fcft_log_class -> IO HsBindgen.Runtime.LibC.CBool)
fcft_init =
  RIP.unsafePerformIO hs_bindgen_d91f0ad496c51ffc

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_fini@
foreign import ccall unsafe "hs_bindgen_71b897e3d8688cc2" hs_bindgen_71b897e3d8688cc2_base ::
     IO (RIP.FunPtr RIP.Void)

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_fini@
hs_bindgen_71b897e3d8688cc2 :: IO (RIP.FunPtr (IO ()))
hs_bindgen_71b897e3d8688cc2 =
  RIP.fromFFIType hs_bindgen_71b897e3d8688cc2_base

{-# NOINLINE fcft_fini #-}
{-| __C declaration:__ @fcft_fini@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 39:6@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
fcft_fini :: RIP.FunPtr (IO ())
fcft_fini =
  RIP.unsafePerformIO hs_bindgen_71b897e3d8688cc2

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_capabilities@
foreign import ccall unsafe "hs_bindgen_eba472cd4dc3c50a" hs_bindgen_eba472cd4dc3c50a_base ::
     IO (RIP.FunPtr RIP.Void)

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_capabilities@
hs_bindgen_eba472cd4dc3c50a :: IO (RIP.FunPtr (IO Fcft_capabilities))
hs_bindgen_eba472cd4dc3c50a =
  RIP.fromFFIType hs_bindgen_eba472cd4dc3c50a_base

{-# NOINLINE fcft_capabilities #-}
{-| __C declaration:__ @fcft_capabilities@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 93:24@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
fcft_capabilities :: RIP.FunPtr (IO Fcft_capabilities)
fcft_capabilities =
  RIP.unsafePerformIO hs_bindgen_eba472cd4dc3c50a

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_clone@
foreign import ccall unsafe "hs_bindgen_1374a19f81956d44" hs_bindgen_1374a19f81956d44_base ::
     IO (RIP.FunPtr RIP.Void)

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_clone@
hs_bindgen_1374a19f81956d44 :: IO (RIP.FunPtr ((PtrConst.PtrConst Fcft_font) -> IO (RIP.Ptr Fcft_font)))
hs_bindgen_1374a19f81956d44 =
  RIP.fromFFIType hs_bindgen_1374a19f81956d44_base

{-# NOINLINE fcft_clone #-}
{-| __C declaration:__ @fcft_clone@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 99:19@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
fcft_clone :: RIP.FunPtr ((PtrConst.PtrConst Fcft_font) -> IO (RIP.Ptr Fcft_font))
fcft_clone =
  RIP.unsafePerformIO hs_bindgen_1374a19f81956d44

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_destroy@
foreign import ccall unsafe "hs_bindgen_854f9510b252c808" hs_bindgen_854f9510b252c808_base ::
     IO (RIP.FunPtr RIP.Void)

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_destroy@
hs_bindgen_854f9510b252c808 :: IO (RIP.FunPtr ((RIP.Ptr Fcft_font) -> IO ()))
hs_bindgen_854f9510b252c808 =
  RIP.fromFFIType hs_bindgen_854f9510b252c808_base

{-# NOINLINE fcft_destroy #-}
{-| __C declaration:__ @fcft_destroy@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 100:6@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
fcft_destroy :: RIP.FunPtr ((RIP.Ptr Fcft_font) -> IO ())
fcft_destroy =
  RIP.unsafePerformIO hs_bindgen_854f9510b252c808

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_kerning@
foreign import ccall unsafe "hs_bindgen_ad6a0fffa0acf165" hs_bindgen_ad6a0fffa0acf165_base ::
     IO (RIP.FunPtr RIP.Void)

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_kerning@
hs_bindgen_ad6a0fffa0acf165 :: IO (RIP.FunPtr ((RIP.Ptr Fcft_font) -> HsBindgen.Runtime.LibC.Word32 -> HsBindgen.Runtime.LibC.Word32 -> (RIP.Ptr RIP.CLong) -> (RIP.Ptr RIP.CLong) -> IO HsBindgen.Runtime.LibC.CBool))
hs_bindgen_ad6a0fffa0acf165 =
  RIP.fromFFIType hs_bindgen_ad6a0fffa0acf165_base

{-# NOINLINE fcft_kerning #-}
{-| __C declaration:__ @fcft_kerning@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 151:6@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
fcft_kerning :: RIP.FunPtr ((RIP.Ptr Fcft_font) -> HsBindgen.Runtime.LibC.Word32 -> HsBindgen.Runtime.LibC.Word32 -> (RIP.Ptr RIP.CLong) -> (RIP.Ptr RIP.CLong) -> IO HsBindgen.Runtime.LibC.CBool)
fcft_kerning =
  RIP.unsafePerformIO hs_bindgen_ad6a0fffa0acf165

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_precompose@
foreign import ccall unsafe "hs_bindgen_3fb59af06d62e5b3" hs_bindgen_3fb59af06d62e5b3_base ::
     IO (RIP.FunPtr RIP.Void)

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_get_fcft_precompose@
hs_bindgen_3fb59af06d62e5b3 :: IO (RIP.FunPtr ((PtrConst.PtrConst Fcft_font) -> HsBindgen.Runtime.LibC.Word32 -> HsBindgen.Runtime.LibC.Word32 -> (RIP.Ptr HsBindgen.Runtime.LibC.CBool) -> (RIP.Ptr HsBindgen.Runtime.LibC.CBool) -> (RIP.Ptr HsBindgen.Runtime.LibC.CBool) -> IO HsBindgen.Runtime.LibC.Word32))
hs_bindgen_3fb59af06d62e5b3 =
  RIP.fromFFIType hs_bindgen_3fb59af06d62e5b3_base

{-# NOINLINE fcft_precompose #-}
{-| __C declaration:__ @fcft_precompose@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 155:10@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
fcft_precompose :: RIP.FunPtr ((PtrConst.PtrConst Fcft_font) -> HsBindgen.Runtime.LibC.Word32 -> HsBindgen.Runtime.LibC.Word32 -> (RIP.Ptr HsBindgen.Runtime.LibC.CBool) -> (RIP.Ptr HsBindgen.Runtime.LibC.CBool) -> (RIP.Ptr HsBindgen.Runtime.LibC.CBool) -> IO HsBindgen.Runtime.LibC.Word32)
fcft_precompose =
  RIP.unsafePerformIO hs_bindgen_3fb59af06d62e5b3
