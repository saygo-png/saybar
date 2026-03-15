{-# LANGUAGE CApiFFI #-}
{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_HADDOCK prune #-}

module Generated.Fcft.Safe
    ( Generated.Fcft.Safe.fcft_init
    , Generated.Fcft.Safe.fcft_fini
    , Generated.Fcft.Safe.fcft_capabilities
    , Generated.Fcft.Safe.fcft_clone
    , Generated.Fcft.Safe.fcft_destroy
    , Generated.Fcft.Safe.fcft_rasterize_char_utf32
    , Generated.Fcft.Safe.fcft_text_run_destroy
    , Generated.Fcft.Safe.fcft_kerning
    , Generated.Fcft.Safe.fcft_precompose
    , Generated.Fcft.Safe.fcft_font_options_create
    , Generated.Fcft.Safe.fcft_font_options_destroy
    )
  where

import qualified HsBindgen.Runtime.Internal.CAPI
import qualified HsBindgen.Runtime.Internal.Prelude as RIP
import qualified HsBindgen.Runtime.LibC
import qualified HsBindgen.Runtime.PtrConst as PtrConst
import Generated.Fcft

$(HsBindgen.Runtime.Internal.CAPI.addCSource (HsBindgen.Runtime.Internal.CAPI.unlines
  [ "#include </nix/store/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3/include/fcft/fcft.h>"
  , "bool hs_bindgen_ae37a8d28b5ca8ef ("
  , "  enum fcft_log_colorize arg1,"
  , "  bool arg2,"
  , "  enum fcft_log_class arg3"
  , ")"
  , "{"
  , "  return (fcft_init)(arg1, arg2, arg3);"
  , "}"
  , "void hs_bindgen_4e2c81a301c0b679 (void)"
  , "{"
  , "  (fcft_fini)();"
  , "}"
  , "enum fcft_capabilities hs_bindgen_9b716774d15e0efb (void)"
  , "{"
  , "  return (fcft_capabilities)();"
  , "}"
  , "struct fcft_font *hs_bindgen_8240be6a3be38593 ("
  , "  struct fcft_font const *arg1"
  , ")"
  , "{"
  , "  return (fcft_clone)(arg1);"
  , "}"
  , "void hs_bindgen_a096ed728acc7872 ("
  , "  struct fcft_font *arg1"
  , ")"
  , "{"
  , "  (fcft_destroy)(arg1);"
  , "}"
  , "struct fcft_glyph const *hs_bindgen_60591091e354f0e4 ("
  , "  struct fcft_font *arg1,"
  , "  uint32_t arg2,"
  , "  enum fcft_subpixel arg3"
  , ")"
  , "{"
  , "  return (fcft_rasterize_char_utf32)(arg1, arg2, arg3);"
  , "}"
  , "void hs_bindgen_75e4652286f9d41f ("
  , "  struct fcft_text_run *arg1"
  , ")"
  , "{"
  , "  (fcft_text_run_destroy)(arg1);"
  , "}"
  , "bool hs_bindgen_a861a66d8739c0b0 ("
  , "  struct fcft_font *arg1,"
  , "  uint32_t arg2,"
  , "  uint32_t arg3,"
  , "  signed long *arg4,"
  , "  signed long *arg5"
  , ")"
  , "{"
  , "  return (fcft_kerning)(arg1, arg2, arg3, arg4, arg5);"
  , "}"
  , "uint32_t hs_bindgen_c626d05f81becbb2 ("
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
  , "struct fcft_font_options *hs_bindgen_191bb661e959c605 (void)"
  , "{"
  , "  return (fcft_font_options_create)();"
  , "}"
  , "void hs_bindgen_f593bb67a3d771bc ("
  , "  struct fcft_font_options *arg1"
  , ")"
  , "{"
  , "  (fcft_font_options_destroy)(arg1);"
  , "}"
  ]))

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Safe_fcft_init@
foreign import ccall safe "hs_bindgen_ae37a8d28b5ca8ef" hs_bindgen_ae37a8d28b5ca8ef_base ::
     RIP.Word32
  -> RIP.Word8
  -> RIP.Word32
  -> IO RIP.Word8

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Safe_fcft_init@
hs_bindgen_ae37a8d28b5ca8ef ::
     Fcft_log_colorize
  -> HsBindgen.Runtime.LibC.CBool
  -> Fcft_log_class
  -> IO HsBindgen.Runtime.LibC.CBool
hs_bindgen_ae37a8d28b5ca8ef =
  RIP.fromFFIType hs_bindgen_ae37a8d28b5ca8ef_base

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
fcft_init = hs_bindgen_ae37a8d28b5ca8ef

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Safe_fcft_fini@
foreign import ccall safe "hs_bindgen_4e2c81a301c0b679" hs_bindgen_4e2c81a301c0b679_base ::
     IO ()

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Safe_fcft_fini@
hs_bindgen_4e2c81a301c0b679 :: IO ()
hs_bindgen_4e2c81a301c0b679 =
  RIP.fromFFIType hs_bindgen_4e2c81a301c0b679_base

{-| __C declaration:__ @fcft_fini@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 39:6@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
fcft_fini :: IO ()
fcft_fini = hs_bindgen_4e2c81a301c0b679

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Safe_fcft_capabilities@
foreign import ccall safe "hs_bindgen_9b716774d15e0efb" hs_bindgen_9b716774d15e0efb_base ::
     IO RIP.Word32

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Safe_fcft_capabilities@
hs_bindgen_9b716774d15e0efb :: IO Fcft_capabilities
hs_bindgen_9b716774d15e0efb =
  RIP.fromFFIType hs_bindgen_9b716774d15e0efb_base

{-| __C declaration:__ @fcft_capabilities@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 93:24@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
fcft_capabilities :: IO Fcft_capabilities
fcft_capabilities = hs_bindgen_9b716774d15e0efb

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Safe_fcft_clone@
foreign import ccall safe "hs_bindgen_8240be6a3be38593" hs_bindgen_8240be6a3be38593_base ::
     RIP.Ptr RIP.Void
  -> IO (RIP.Ptr RIP.Void)

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Safe_fcft_clone@
hs_bindgen_8240be6a3be38593 ::
     PtrConst.PtrConst Fcft_font
  -> IO (RIP.Ptr Fcft_font)
hs_bindgen_8240be6a3be38593 =
  RIP.fromFFIType hs_bindgen_8240be6a3be38593_base

{-| __C declaration:__ @fcft_clone@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 99:19@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
fcft_clone ::
     PtrConst.PtrConst Fcft_font
     -- ^ __C declaration:__ @font@
  -> IO (RIP.Ptr Fcft_font)
fcft_clone = hs_bindgen_8240be6a3be38593

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Safe_fcft_destroy@
foreign import ccall safe "hs_bindgen_a096ed728acc7872" hs_bindgen_a096ed728acc7872_base ::
     RIP.Ptr RIP.Void
  -> IO ()

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Safe_fcft_destroy@
hs_bindgen_a096ed728acc7872 ::
     RIP.Ptr Fcft_font
  -> IO ()
hs_bindgen_a096ed728acc7872 =
  RIP.fromFFIType hs_bindgen_a096ed728acc7872_base

{-| __C declaration:__ @fcft_destroy@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 100:6@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
fcft_destroy ::
     RIP.Ptr Fcft_font
     -- ^ __C declaration:__ @font@
  -> IO ()
fcft_destroy = hs_bindgen_a096ed728acc7872

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Safe_fcft_rasterize_char_utf32@
foreign import ccall safe "hs_bindgen_60591091e354f0e4" hs_bindgen_60591091e354f0e4_base ::
     RIP.Ptr RIP.Void
  -> RIP.Word32
  -> RIP.Word32
  -> IO (RIP.Ptr RIP.Void)

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Safe_fcft_rasterize_char_utf32@
hs_bindgen_60591091e354f0e4 ::
     RIP.Ptr Fcft_font
  -> HsBindgen.Runtime.LibC.Word32
  -> Fcft_subpixel
  -> IO (PtrConst.PtrConst Fcft_glyph)
hs_bindgen_60591091e354f0e4 =
  RIP.fromFFIType hs_bindgen_60591091e354f0e4_base

{-| __C declaration:__ @fcft_rasterize_char_utf32@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 124:26@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
fcft_rasterize_char_utf32 ::
     RIP.Ptr Fcft_font
     -- ^ __C declaration:__ @font@
  -> HsBindgen.Runtime.LibC.Word32
     -- ^ __C declaration:__ @cp@
  -> Fcft_subpixel
     -- ^ __C declaration:__ @subpixel@
  -> IO (PtrConst.PtrConst Fcft_glyph)
fcft_rasterize_char_utf32 =
  hs_bindgen_60591091e354f0e4

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Safe_fcft_text_run_destroy@
foreign import ccall safe "hs_bindgen_75e4652286f9d41f" hs_bindgen_75e4652286f9d41f_base ::
     RIP.Ptr RIP.Void
  -> IO ()

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Safe_fcft_text_run_destroy@
hs_bindgen_75e4652286f9d41f ::
     RIP.Ptr Fcft_text_run
  -> IO ()
hs_bindgen_75e4652286f9d41f =
  RIP.fromFFIType hs_bindgen_75e4652286f9d41f_base

{-| __C declaration:__ @fcft_text_run_destroy@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 149:6@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
fcft_text_run_destroy ::
     RIP.Ptr Fcft_text_run
     -- ^ __C declaration:__ @run@
  -> IO ()
fcft_text_run_destroy = hs_bindgen_75e4652286f9d41f

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Safe_fcft_kerning@
foreign import ccall safe "hs_bindgen_a861a66d8739c0b0" hs_bindgen_a861a66d8739c0b0_base ::
     RIP.Ptr RIP.Void
  -> RIP.Word32
  -> RIP.Word32
  -> RIP.Ptr RIP.Void
  -> RIP.Ptr RIP.Void
  -> IO RIP.Word8

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Safe_fcft_kerning@
hs_bindgen_a861a66d8739c0b0 ::
     RIP.Ptr Fcft_font
  -> HsBindgen.Runtime.LibC.Word32
  -> HsBindgen.Runtime.LibC.Word32
  -> RIP.Ptr RIP.CLong
  -> RIP.Ptr RIP.CLong
  -> IO HsBindgen.Runtime.LibC.CBool
hs_bindgen_a861a66d8739c0b0 =
  RIP.fromFFIType hs_bindgen_a861a66d8739c0b0_base

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
fcft_kerning = hs_bindgen_a861a66d8739c0b0

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Safe_fcft_precompose@
foreign import ccall safe "hs_bindgen_c626d05f81becbb2" hs_bindgen_c626d05f81becbb2_base ::
     RIP.Ptr RIP.Void
  -> RIP.Word32
  -> RIP.Word32
  -> RIP.Ptr RIP.Void
  -> RIP.Ptr RIP.Void
  -> RIP.Ptr RIP.Void
  -> IO RIP.Word32

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Safe_fcft_precompose@
hs_bindgen_c626d05f81becbb2 ::
     PtrConst.PtrConst Fcft_font
  -> HsBindgen.Runtime.LibC.Word32
  -> HsBindgen.Runtime.LibC.Word32
  -> RIP.Ptr HsBindgen.Runtime.LibC.CBool
  -> RIP.Ptr HsBindgen.Runtime.LibC.CBool
  -> RIP.Ptr HsBindgen.Runtime.LibC.CBool
  -> IO HsBindgen.Runtime.LibC.Word32
hs_bindgen_c626d05f81becbb2 =
  RIP.fromFFIType hs_bindgen_c626d05f81becbb2_base

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
fcft_precompose = hs_bindgen_c626d05f81becbb2

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Safe_fcft_font_options_create@
foreign import ccall safe "hs_bindgen_191bb661e959c605" hs_bindgen_191bb661e959c605_base ::
     IO (RIP.Ptr RIP.Void)

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Safe_fcft_font_options_create@
hs_bindgen_191bb661e959c605 :: IO (RIP.Ptr Fcft_font_options)
hs_bindgen_191bb661e959c605 =
  RIP.fromFFIType hs_bindgen_191bb661e959c605_base

{-| __C declaration:__ @fcft_font_options_create@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 234:27@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
fcft_font_options_create :: IO (RIP.Ptr Fcft_font_options)
fcft_font_options_create =
  hs_bindgen_191bb661e959c605

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Safe_fcft_font_options_destroy@
foreign import ccall safe "hs_bindgen_f593bb67a3d771bc" hs_bindgen_f593bb67a3d771bc_base ::
     RIP.Ptr RIP.Void
  -> IO ()

-- __unique:__ @saygo_bindings_fcft_Generated.Fcft_Safe_fcft_font_options_destroy@
hs_bindgen_f593bb67a3d771bc ::
     RIP.Ptr Fcft_font_options
  -> IO ()
hs_bindgen_f593bb67a3d771bc =
  RIP.fromFFIType hs_bindgen_f593bb67a3d771bc_base

{-| __C declaration:__ @fcft_font_options_destroy@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 235:6@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
fcft_font_options_destroy ::
     RIP.Ptr Fcft_font_options
     -- ^ __C declaration:__ @options@
  -> IO ()
fcft_font_options_destroy =
  hs_bindgen_f593bb67a3d771bc
