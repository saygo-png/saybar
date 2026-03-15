{-# LANGUAGE CApiFFI #-}
{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_HADDOCK prune #-}

module Generated.Fcft.Unsafe
    ( Generated.Fcft.Unsafe.fcft_init
    , Generated.Fcft.Unsafe.fcft_fini
    , Generated.Fcft.Unsafe.fcft_capabilities
    , Generated.Fcft.Unsafe.fcft_clone
    , Generated.Fcft.Unsafe.fcft_destroy
    , Generated.Fcft.Unsafe.fcft_kerning
    , Generated.Fcft.Unsafe.fcft_precompose
    )
  where

import qualified HsBindgen.Runtime.Internal.CAPI
import qualified HsBindgen.Runtime.Internal.Prelude as RIP
import qualified HsBindgen.Runtime.LibC
import qualified HsBindgen.Runtime.PtrConst as PtrConst
import Generated.Fcft

$(HsBindgen.Runtime.Internal.CAPI.addCSource (HsBindgen.Runtime.Internal.CAPI.unlines
  [ "#include </nix/store/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3/include/fcft/fcft.h>"
  , "bool hs_bindgen_fa1224be4b25632f ("
  , "  enum fcft_log_colorize arg1,"
  , "  bool arg2,"
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
  , "bool hs_bindgen_cf920e20ff93f95c ("
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
  , "  bool *arg4,"
  , "  bool *arg5,"
  , "  bool *arg6"
  , ")"
  , "{"
  , "  return (fcft_precompose)(arg1, arg2, arg3, arg4, arg5, arg6);"
  , "}"
  ]))

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_init@
foreign import ccall unsafe "hs_bindgen_fa1224be4b25632f" hs_bindgen_fa1224be4b25632f_base ::
     RIP.Word32
  -> RIP.Word8
  -> RIP.Word32
  -> IO RIP.Word8

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_init@
hs_bindgen_fa1224be4b25632f ::
     Fcft_log_colorize
  -> HsBindgen.Runtime.LibC.CBool
  -> Fcft_log_class
  -> IO HsBindgen.Runtime.LibC.CBool
hs_bindgen_fa1224be4b25632f =
  RIP.fromFFIType hs_bindgen_fa1224be4b25632f_base

{-| __C declaration:__ @fcft_init@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 35:6@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
fcft_init ::
     Fcft_log_colorize
     -- ^ __C declaration:__ @colorize@
  -> HsBindgen.Runtime.LibC.CBool
     -- ^ __C declaration:__ @do_syslog@
  -> Fcft_log_class
     -- ^ __C declaration:__ @log_level@
  -> IO HsBindgen.Runtime.LibC.CBool
fcft_init = hs_bindgen_fa1224be4b25632f

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_fini@
foreign import ccall unsafe "hs_bindgen_69c4bb20db51ee83" hs_bindgen_69c4bb20db51ee83_base ::
     IO ()

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_fini@
hs_bindgen_69c4bb20db51ee83 :: IO ()
hs_bindgen_69c4bb20db51ee83 =
  RIP.fromFFIType hs_bindgen_69c4bb20db51ee83_base

{-| __C declaration:__ @fcft_fini@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 39:6@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
fcft_fini :: IO ()
fcft_fini = hs_bindgen_69c4bb20db51ee83

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_capabilities@
foreign import ccall unsafe "hs_bindgen_6a4c43aab094d0d4" hs_bindgen_6a4c43aab094d0d4_base ::
     IO RIP.Word32

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_capabilities@
hs_bindgen_6a4c43aab094d0d4 :: IO Fcft_capabilities
hs_bindgen_6a4c43aab094d0d4 =
  RIP.fromFFIType hs_bindgen_6a4c43aab094d0d4_base

{-| __C declaration:__ @fcft_capabilities@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 93:24@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
fcft_capabilities :: IO Fcft_capabilities
fcft_capabilities = hs_bindgen_6a4c43aab094d0d4

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_clone@
foreign import ccall unsafe "hs_bindgen_b067eb5bd062f407" hs_bindgen_b067eb5bd062f407_base ::
     RIP.Ptr RIP.Void
  -> IO (RIP.Ptr RIP.Void)

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_clone@
hs_bindgen_b067eb5bd062f407 ::
     PtrConst.PtrConst Fcft_font
  -> IO (RIP.Ptr Fcft_font)
hs_bindgen_b067eb5bd062f407 =
  RIP.fromFFIType hs_bindgen_b067eb5bd062f407_base

{-| __C declaration:__ @fcft_clone@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 99:19@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
fcft_clone ::
     PtrConst.PtrConst Fcft_font
     -- ^ __C declaration:__ @font@
  -> IO (RIP.Ptr Fcft_font)
fcft_clone = hs_bindgen_b067eb5bd062f407

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_destroy@
foreign import ccall unsafe "hs_bindgen_a0590b2acd888cfd" hs_bindgen_a0590b2acd888cfd_base ::
     RIP.Ptr RIP.Void
  -> IO ()

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_destroy@
hs_bindgen_a0590b2acd888cfd ::
     RIP.Ptr Fcft_font
  -> IO ()
hs_bindgen_a0590b2acd888cfd =
  RIP.fromFFIType hs_bindgen_a0590b2acd888cfd_base

{-| __C declaration:__ @fcft_destroy@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 100:6@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
fcft_destroy ::
     RIP.Ptr Fcft_font
     -- ^ __C declaration:__ @font@
  -> IO ()
fcft_destroy = hs_bindgen_a0590b2acd888cfd

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_kerning@
foreign import ccall unsafe "hs_bindgen_cf920e20ff93f95c" hs_bindgen_cf920e20ff93f95c_base ::
     RIP.Ptr RIP.Void
  -> RIP.Word32
  -> RIP.Word32
  -> RIP.Ptr RIP.Void
  -> RIP.Ptr RIP.Void
  -> IO RIP.Word8

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_kerning@
hs_bindgen_cf920e20ff93f95c ::
     RIP.Ptr Fcft_font
  -> HsBindgen.Runtime.LibC.Word32
  -> HsBindgen.Runtime.LibC.Word32
  -> RIP.Ptr RIP.CLong
  -> RIP.Ptr RIP.CLong
  -> IO HsBindgen.Runtime.LibC.CBool
hs_bindgen_cf920e20ff93f95c =
  RIP.fromFFIType hs_bindgen_cf920e20ff93f95c_base

{-| __C declaration:__ @fcft_kerning@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 151:6@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
fcft_kerning ::
     RIP.Ptr Fcft_font
     -- ^ __C declaration:__ @font@
  -> HsBindgen.Runtime.LibC.Word32
     -- ^ __C declaration:__ @left@
  -> HsBindgen.Runtime.LibC.Word32
     -- ^ __C declaration:__ @right@
  -> RIP.Ptr RIP.CLong
     -- ^ __C declaration:__ @x@
  -> RIP.Ptr RIP.CLong
     -- ^ __C declaration:__ @y@
  -> IO HsBindgen.Runtime.LibC.CBool
fcft_kerning = hs_bindgen_cf920e20ff93f95c

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_precompose@
foreign import ccall unsafe "hs_bindgen_8009f0fea2a2778b" hs_bindgen_8009f0fea2a2778b_base ::
     RIP.Ptr RIP.Void
  -> RIP.Word32
  -> RIP.Word32
  -> RIP.Ptr RIP.Void
  -> RIP.Ptr RIP.Void
  -> RIP.Ptr RIP.Void
  -> IO RIP.Word32

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Unsafe_fcft_precompose@
hs_bindgen_8009f0fea2a2778b ::
     PtrConst.PtrConst Fcft_font
  -> HsBindgen.Runtime.LibC.Word32
  -> HsBindgen.Runtime.LibC.Word32
  -> RIP.Ptr HsBindgen.Runtime.LibC.CBool
  -> RIP.Ptr HsBindgen.Runtime.LibC.CBool
  -> RIP.Ptr HsBindgen.Runtime.LibC.CBool
  -> IO HsBindgen.Runtime.LibC.Word32
hs_bindgen_8009f0fea2a2778b =
  RIP.fromFFIType hs_bindgen_8009f0fea2a2778b_base

{-| __C declaration:__ @fcft_precompose@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 155:10@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
fcft_precompose ::
     PtrConst.PtrConst Fcft_font
     -- ^ __C declaration:__ @font@
  -> HsBindgen.Runtime.LibC.Word32
     -- ^ __C declaration:__ @base@
  -> HsBindgen.Runtime.LibC.Word32
     -- ^ __C declaration:__ @comb@
  -> RIP.Ptr HsBindgen.Runtime.LibC.CBool
     -- ^ __C declaration:__ @base_is_from_primary@
  -> RIP.Ptr HsBindgen.Runtime.LibC.CBool
     -- ^ __C declaration:__ @comb_is_from_primary@
  -> RIP.Ptr HsBindgen.Runtime.LibC.CBool
     -- ^ __C declaration:__ @composed_is_from_primary@
  -> IO HsBindgen.Runtime.LibC.Word32
fcft_precompose = hs_bindgen_8009f0fea2a2778b
