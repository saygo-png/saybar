{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE EmptyDataDecls #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MagicHash #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE PatternSynonyms #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE UnboxedTuples #-}
{-# LANGUAGE UndecidableInstances #-}

module Generated.Fcft
    ( Generated.Fcft.Pixman_image_t
    , Generated.Fcft.Pixman_format_code_t(..)
    , pattern Generated.Fcft.PIXMAN_rgba_float
    , pattern Generated.Fcft.PIXMAN_rgb_float
    , pattern Generated.Fcft.PIXMAN_a16b16g16r16
    , pattern Generated.Fcft.PIXMAN_a8r8g8b8
    , pattern Generated.Fcft.PIXMAN_x8r8g8b8
    , pattern Generated.Fcft.PIXMAN_a8b8g8r8
    , pattern Generated.Fcft.PIXMAN_x8b8g8r8
    , pattern Generated.Fcft.PIXMAN_b8g8r8a8
    , pattern Generated.Fcft.PIXMAN_b8g8r8x8
    , pattern Generated.Fcft.PIXMAN_r8g8b8a8
    , pattern Generated.Fcft.PIXMAN_r8g8b8x8
    , pattern Generated.Fcft.PIXMAN_x14r6g6b6
    , pattern Generated.Fcft.PIXMAN_x2r10g10b10
    , pattern Generated.Fcft.PIXMAN_a2r10g10b10
    , pattern Generated.Fcft.PIXMAN_x2b10g10r10
    , pattern Generated.Fcft.PIXMAN_a2b10g10r10
    , pattern Generated.Fcft.PIXMAN_a8r8g8b8_sRGB
    , pattern Generated.Fcft.PIXMAN_r8g8b8_sRGB
    , pattern Generated.Fcft.PIXMAN_r8g8b8
    , pattern Generated.Fcft.PIXMAN_b8g8r8
    , pattern Generated.Fcft.PIXMAN_r5g6b5
    , pattern Generated.Fcft.PIXMAN_b5g6r5
    , pattern Generated.Fcft.PIXMAN_a1r5g5b5
    , pattern Generated.Fcft.PIXMAN_x1r5g5b5
    , pattern Generated.Fcft.PIXMAN_a1b5g5r5
    , pattern Generated.Fcft.PIXMAN_x1b5g5r5
    , pattern Generated.Fcft.PIXMAN_a4r4g4b4
    , pattern Generated.Fcft.PIXMAN_x4r4g4b4
    , pattern Generated.Fcft.PIXMAN_a4b4g4r4
    , pattern Generated.Fcft.PIXMAN_x4b4g4r4
    , pattern Generated.Fcft.PIXMAN_a8
    , pattern Generated.Fcft.PIXMAN_r3g3b2
    , pattern Generated.Fcft.PIXMAN_b2g3r3
    , pattern Generated.Fcft.PIXMAN_a2r2g2b2
    , pattern Generated.Fcft.PIXMAN_a2b2g2r2
    , pattern Generated.Fcft.PIXMAN_c8
    , pattern Generated.Fcft.PIXMAN_g8
    , pattern Generated.Fcft.PIXMAN_x4a4
    , pattern Generated.Fcft.PIXMAN_x4c4
    , pattern Generated.Fcft.PIXMAN_x4g4
    , pattern Generated.Fcft.PIXMAN_a4
    , pattern Generated.Fcft.PIXMAN_r1g2b1
    , pattern Generated.Fcft.PIXMAN_b1g2r1
    , pattern Generated.Fcft.PIXMAN_a1r1g1b1
    , pattern Generated.Fcft.PIXMAN_a1b1g1r1
    , pattern Generated.Fcft.PIXMAN_c4
    , pattern Generated.Fcft.PIXMAN_g4
    , pattern Generated.Fcft.PIXMAN_a1
    , pattern Generated.Fcft.PIXMAN_g1
    , pattern Generated.Fcft.PIXMAN_yuy2
    , pattern Generated.Fcft.PIXMAN_yv12
    , Generated.Fcft.Fcft_log_colorize(..)
    , pattern Generated.Fcft.FCFT_LOG_COLORIZE_NEVER
    , pattern Generated.Fcft.FCFT_LOG_COLORIZE_ALWAYS
    , pattern Generated.Fcft.FCFT_LOG_COLORIZE_AUTO
    , Generated.Fcft.Fcft_log_class(..)
    , pattern Generated.Fcft.FCFT_LOG_CLASS_NONE
    , pattern Generated.Fcft.FCFT_LOG_CLASS_ERROR
    , pattern Generated.Fcft.FCFT_LOG_CLASS_WARNING
    , pattern Generated.Fcft.FCFT_LOG_CLASS_INFO
    , pattern Generated.Fcft.FCFT_LOG_CLASS_DEBUG
    , Generated.Fcft.Fcft_subpixel(..)
    , pattern Generated.Fcft.FCFT_SUBPIXEL_DEFAULT
    , pattern Generated.Fcft.FCFT_SUBPIXEL_NONE
    , pattern Generated.Fcft.FCFT_SUBPIXEL_HORIZONTAL_RGB
    , pattern Generated.Fcft.FCFT_SUBPIXEL_HORIZONTAL_BGR
    , pattern Generated.Fcft.FCFT_SUBPIXEL_VERTICAL_RGB
    , pattern Generated.Fcft.FCFT_SUBPIXEL_VERTICAL_BGR
    , Generated.Fcft.Fcft_font_max_advance(..)
    , Generated.Fcft.Fcft_font_underline(..)
    , Generated.Fcft.Fcft_font_strikeout(..)
    , Generated.Fcft.Fcft_font(..)
    , Generated.Fcft.Fcft_capabilities(..)
    , pattern Generated.Fcft.FCFT_CAPABILITY_GRAPHEME_SHAPING
    , pattern Generated.Fcft.FCFT_CAPABILITY_TEXT_RUN_SHAPING
    , pattern Generated.Fcft.FCFT_CAPABILITY_SVG
    , Generated.Fcft.Fcft_glyph_advance(..)
    , Generated.Fcft.Fcft_glyph(..)
    , Generated.Fcft.Fcft_grapheme(..)
    , Generated.Fcft.Fcft_text_run(..)
    , Generated.Fcft.Fcft_scaling_filter(..)
    , pattern Generated.Fcft.FCFT_SCALING_FILTER_NONE
    , pattern Generated.Fcft.FCFT_SCALING_FILTER_NEAREST
    , pattern Generated.Fcft.FCFT_SCALING_FILTER_BILINEAR
    , pattern Generated.Fcft.FCFT_SCALING_FILTER_CUBIC
    , pattern Generated.Fcft.FCFT_SCALING_FILTER_LANCZOS3
    , pattern Generated.Fcft.FCFT_SCALING_FILTER_IMPULSE
    , pattern Generated.Fcft.FCFT_SCALING_FILTER_BOX
    , pattern Generated.Fcft.FCFT_SCALING_FILTER_LINEAR
    , pattern Generated.Fcft.FCFT_SCALING_FILTER_GAUSSIAN
    , pattern Generated.Fcft.FCFT_SCALING_FILTER_LANCZOS2
    , pattern Generated.Fcft.FCFT_SCALING_FILTER_LANCZOS3_STRETCHED
    , Generated.Fcft.Fcft_emoji_presentation(..)
    , pattern Generated.Fcft.FCFT_EMOJI_PRESENTATION_DEFAULT
    , pattern Generated.Fcft.FCFT_EMOJI_PRESENTATION_TEXT
    , pattern Generated.Fcft.FCFT_EMOJI_PRESENTATION_EMOJI
    , Generated.Fcft.Fcft_font_options_color_glyphs(..)
    , Generated.Fcft.Fcft_font_options(..)
    )
  where

import qualified HsBindgen.Runtime.CEnum as CEnum
import qualified HsBindgen.Runtime.HasCField as HasCField
import qualified HsBindgen.Runtime.Internal.Prelude as RIP
import qualified HsBindgen.Runtime.LibC
import qualified HsBindgen.Runtime.Marshal as Marshal
import qualified HsBindgen.Runtime.PtrConst as PtrConst

{-| __C declaration:__ @union pixman_image@

    __defined at:__ @pixman.h 185:16@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
data Pixman_image_t

{-| __C declaration:__ @enum pixman_format_code_t@

    __defined at:__ @pixman.h 1055:9@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
newtype Pixman_format_code_t = Pixman_format_code_t
  { unwrapPixman_format_code_t :: RIP.CUInt
  }
  deriving stock (Eq, RIP.Generic, Ord)
  deriving newtype (RIP.HasFFIType)

instance Marshal.StaticSize Pixman_format_code_t where

  staticSizeOf = \_ -> (4 :: Int)

  staticAlignment = \_ -> (4 :: Int)

instance Marshal.ReadRaw Pixman_format_code_t where

  readRaw =
    \ptr0 ->
          pure Pixman_format_code_t
      <*> Marshal.readRawByteOff ptr0 (0 :: Int)

instance Marshal.WriteRaw Pixman_format_code_t where

  writeRaw =
    \ptr0 ->
      \s1 ->
        case s1 of
          Pixman_format_code_t unwrapPixman_format_code_t2 ->
            Marshal.writeRawByteOff ptr0 (0 :: Int) unwrapPixman_format_code_t2

deriving via Marshal.EquivStorable Pixman_format_code_t instance RIP.Storable Pixman_format_code_t

deriving via RIP.CUInt instance RIP.Prim Pixman_format_code_t

instance CEnum.CEnum Pixman_format_code_t where

  type CEnumZ Pixman_format_code_t = RIP.CUInt

  toCEnum = Pixman_format_code_t

  fromCEnum = unwrapPixman_format_code_t

  declaredValues =
    \_ ->
      CEnum.declaredValuesFromList [ (16846848, RIP.singleton "PIXMAN_a1")
                                   , (17104896, RIP.singleton "PIXMAN_g1")
                                   , (67190784, RIP.singleton "PIXMAN_a4")
                                   , (67240225, RIP.singleton "PIXMAN_r1g2b1")
                                   , (67244305, RIP.singleton "PIXMAN_a1r1g1b1")
                                   , (67305761, RIP.singleton "PIXMAN_b1g2r1")
                                   , (67309841, RIP.singleton "PIXMAN_a1b1g1r1")
                                   , (67371008, RIP.singleton "PIXMAN_c4")
                                   , (67436544, RIP.singleton "PIXMAN_g4")
                                   , (134299648, RIP.singleton "PIXMAN_x4a4")
                                   , (134316032, RIP.singleton "PIXMAN_a8")
                                   , (134349618, RIP.singleton "PIXMAN_r3g3b2")
                                   , (134357538, RIP.singleton "PIXMAN_a2r2g2b2")
                                   , (134415154, RIP.singleton "PIXMAN_b2g3r3")
                                   , (134423074, RIP.singleton "PIXMAN_a2b2g2r2")
                                   , (134479872, ("PIXMAN_c8" RIP.:| ["PIXMAN_x4c4"]))
                                   , (134545408, ("PIXMAN_g8" RIP.:| ["PIXMAN_x4g4"]))
                                   , (147005986, RIP.singleton "PIXMAN_a16b16g16r16")
                                   , (201785344, RIP.singleton "PIXMAN_yv12")
                                   , (214631492, RIP.singleton "PIXMAN_rgb_float")
                                   , (268567620, RIP.singleton "PIXMAN_x4r4g4b4")
                                   , (268567893, RIP.singleton "PIXMAN_x1r5g5b5")
                                   , (268567909, RIP.singleton "PIXMAN_r5g6b5")
                                   , (268571989, RIP.singleton "PIXMAN_a1r5g5b5")
                                   , (268584004, RIP.singleton "PIXMAN_a4r4g4b4")
                                   , (268633156, RIP.singleton "PIXMAN_x4b4g4r4")
                                   , (268633429, RIP.singleton "PIXMAN_x1b5g5r5")
                                   , (268633445, RIP.singleton "PIXMAN_b5g6r5")
                                   , (268637525, RIP.singleton "PIXMAN_a1b5g5r5")
                                   , (268649540, RIP.singleton "PIXMAN_a4b4g4r4")
                                   , (268828672, RIP.singleton "PIXMAN_yuy2")
                                   , (281756740, RIP.singleton "PIXMAN_rgba_float")
                                   , (402786440, RIP.singleton "PIXMAN_r8g8b8")
                                   , (402851976, RIP.singleton "PIXMAN_b8g8r8")
                                   , (403310728, RIP.singleton "PIXMAN_r8g8b8_sRGB")
                                   , (537003622, RIP.singleton "PIXMAN_x14r6g6b6")
                                   , (537004168, RIP.singleton "PIXMAN_x8r8g8b8")
                                   , (537004714, RIP.singleton "PIXMAN_x2r10g10b10")
                                   , (537012906, RIP.singleton "PIXMAN_a2r10g10b10")
                                   , (537036936, RIP.singleton "PIXMAN_a8r8g8b8")
                                   , (537069704, RIP.singleton "PIXMAN_x8b8g8r8")
                                   , (537070250, RIP.singleton "PIXMAN_x2b10g10r10")
                                   , (537078442, RIP.singleton "PIXMAN_a2b10g10r10")
                                   , (537102472, RIP.singleton "PIXMAN_a8b8g8r8")
                                   , (537397384, RIP.singleton "PIXMAN_b8g8r8x8")
                                   , (537430152, RIP.singleton "PIXMAN_b8g8r8a8")
                                   , (537462920, RIP.singleton "PIXMAN_r8g8b8x8")
                                   , (537495688, RIP.singleton "PIXMAN_r8g8b8a8")
                                   , (537561224, RIP.singleton "PIXMAN_a8r8g8b8_sRGB")
                                   ]

  showsUndeclared =
    CEnum.showsWrappedUndeclared "Pixman_format_code_t"

  readPrecUndeclared =
    CEnum.readPrecWrappedUndeclared "Pixman_format_code_t"

instance Show Pixman_format_code_t where

  showsPrec = CEnum.shows

instance Read Pixman_format_code_t where

  readPrec = CEnum.readPrec

  readList = RIP.readListDefault

  readListPrec = RIP.readListPrecDefault

instance ( ((~) ty) RIP.CUInt
         ) => RIP.HasField "unwrapPixman_format_code_t" (RIP.Ptr Pixman_format_code_t) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"unwrapPixman_format_code_t")

instance HasCField.HasCField Pixman_format_code_t "unwrapPixman_format_code_t" where

  type CFieldType Pixman_format_code_t "unwrapPixman_format_code_t" =
    RIP.CUInt

  offset# = \_ -> \_ -> 0

{-| __C declaration:__ @PIXMAN_rgba_float@

    __defined at:__ @pixman.h 1057:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_rgba_float :: Pixman_format_code_t
pattern PIXMAN_rgba_float = Pixman_format_code_t 281756740

{-| __C declaration:__ @PIXMAN_rgb_float@

    __defined at:__ @pixman.h 1059:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_rgb_float :: Pixman_format_code_t
pattern PIXMAN_rgb_float = Pixman_format_code_t 214631492

{-| __C declaration:__ @PIXMAN_a16b16g16r16@

    __defined at:__ @pixman.h 1063:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_a16b16g16r16 :: Pixman_format_code_t
pattern PIXMAN_a16b16g16r16 = Pixman_format_code_t 147005986

{-| __C declaration:__ @PIXMAN_a8r8g8b8@

    __defined at:__ @pixman.h 1066:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_a8r8g8b8 :: Pixman_format_code_t
pattern PIXMAN_a8r8g8b8 = Pixman_format_code_t 537036936

{-| __C declaration:__ @PIXMAN_x8r8g8b8@

    __defined at:__ @pixman.h 1067:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_x8r8g8b8 :: Pixman_format_code_t
pattern PIXMAN_x8r8g8b8 = Pixman_format_code_t 537004168

{-| __C declaration:__ @PIXMAN_a8b8g8r8@

    __defined at:__ @pixman.h 1068:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_a8b8g8r8 :: Pixman_format_code_t
pattern PIXMAN_a8b8g8r8 = Pixman_format_code_t 537102472

{-| __C declaration:__ @PIXMAN_x8b8g8r8@

    __defined at:__ @pixman.h 1069:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_x8b8g8r8 :: Pixman_format_code_t
pattern PIXMAN_x8b8g8r8 = Pixman_format_code_t 537069704

{-| __C declaration:__ @PIXMAN_b8g8r8a8@

    __defined at:__ @pixman.h 1070:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_b8g8r8a8 :: Pixman_format_code_t
pattern PIXMAN_b8g8r8a8 = Pixman_format_code_t 537430152

{-| __C declaration:__ @PIXMAN_b8g8r8x8@

    __defined at:__ @pixman.h 1071:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_b8g8r8x8 :: Pixman_format_code_t
pattern PIXMAN_b8g8r8x8 = Pixman_format_code_t 537397384

{-| __C declaration:__ @PIXMAN_r8g8b8a8@

    __defined at:__ @pixman.h 1072:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_r8g8b8a8 :: Pixman_format_code_t
pattern PIXMAN_r8g8b8a8 = Pixman_format_code_t 537495688

{-| __C declaration:__ @PIXMAN_r8g8b8x8@

    __defined at:__ @pixman.h 1073:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_r8g8b8x8 :: Pixman_format_code_t
pattern PIXMAN_r8g8b8x8 = Pixman_format_code_t 537462920

{-| __C declaration:__ @PIXMAN_x14r6g6b6@

    __defined at:__ @pixman.h 1074:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_x14r6g6b6 :: Pixman_format_code_t
pattern PIXMAN_x14r6g6b6 = Pixman_format_code_t 537003622

{-| __C declaration:__ @PIXMAN_x2r10g10b10@

    __defined at:__ @pixman.h 1075:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_x2r10g10b10 :: Pixman_format_code_t
pattern PIXMAN_x2r10g10b10 = Pixman_format_code_t 537004714

{-| __C declaration:__ @PIXMAN_a2r10g10b10@

    __defined at:__ @pixman.h 1076:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_a2r10g10b10 :: Pixman_format_code_t
pattern PIXMAN_a2r10g10b10 = Pixman_format_code_t 537012906

{-| __C declaration:__ @PIXMAN_x2b10g10r10@

    __defined at:__ @pixman.h 1077:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_x2b10g10r10 :: Pixman_format_code_t
pattern PIXMAN_x2b10g10r10 = Pixman_format_code_t 537070250

{-| __C declaration:__ @PIXMAN_a2b10g10r10@

    __defined at:__ @pixman.h 1078:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_a2b10g10r10 :: Pixman_format_code_t
pattern PIXMAN_a2b10g10r10 = Pixman_format_code_t 537078442

{-| __C declaration:__ @PIXMAN_a8r8g8b8_sRGB@

    __defined at:__ @pixman.h 1081:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_a8r8g8b8_sRGB :: Pixman_format_code_t
pattern PIXMAN_a8r8g8b8_sRGB = Pixman_format_code_t 537561224

{-| __C declaration:__ @PIXMAN_r8g8b8_sRGB@

    __defined at:__ @pixman.h 1082:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_r8g8b8_sRGB :: Pixman_format_code_t
pattern PIXMAN_r8g8b8_sRGB = Pixman_format_code_t 403310728

{-| __C declaration:__ @PIXMAN_r8g8b8@

    __defined at:__ @pixman.h 1085:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_r8g8b8 :: Pixman_format_code_t
pattern PIXMAN_r8g8b8 = Pixman_format_code_t 402786440

{-| __C declaration:__ @PIXMAN_b8g8r8@

    __defined at:__ @pixman.h 1086:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_b8g8r8 :: Pixman_format_code_t
pattern PIXMAN_b8g8r8 = Pixman_format_code_t 402851976

{-| __C declaration:__ @PIXMAN_r5g6b5@

    __defined at:__ @pixman.h 1089:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_r5g6b5 :: Pixman_format_code_t
pattern PIXMAN_r5g6b5 = Pixman_format_code_t 268567909

{-| __C declaration:__ @PIXMAN_b5g6r5@

    __defined at:__ @pixman.h 1090:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_b5g6r5 :: Pixman_format_code_t
pattern PIXMAN_b5g6r5 = Pixman_format_code_t 268633445

{-| __C declaration:__ @PIXMAN_a1r5g5b5@

    __defined at:__ @pixman.h 1092:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_a1r5g5b5 :: Pixman_format_code_t
pattern PIXMAN_a1r5g5b5 = Pixman_format_code_t 268571989

{-| __C declaration:__ @PIXMAN_x1r5g5b5@

    __defined at:__ @pixman.h 1093:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_x1r5g5b5 :: Pixman_format_code_t
pattern PIXMAN_x1r5g5b5 = Pixman_format_code_t 268567893

{-| __C declaration:__ @PIXMAN_a1b5g5r5@

    __defined at:__ @pixman.h 1094:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_a1b5g5r5 :: Pixman_format_code_t
pattern PIXMAN_a1b5g5r5 = Pixman_format_code_t 268637525

{-| __C declaration:__ @PIXMAN_x1b5g5r5@

    __defined at:__ @pixman.h 1095:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_x1b5g5r5 :: Pixman_format_code_t
pattern PIXMAN_x1b5g5r5 = Pixman_format_code_t 268633429

{-| __C declaration:__ @PIXMAN_a4r4g4b4@

    __defined at:__ @pixman.h 1096:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_a4r4g4b4 :: Pixman_format_code_t
pattern PIXMAN_a4r4g4b4 = Pixman_format_code_t 268584004

{-| __C declaration:__ @PIXMAN_x4r4g4b4@

    __defined at:__ @pixman.h 1097:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_x4r4g4b4 :: Pixman_format_code_t
pattern PIXMAN_x4r4g4b4 = Pixman_format_code_t 268567620

{-| __C declaration:__ @PIXMAN_a4b4g4r4@

    __defined at:__ @pixman.h 1098:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_a4b4g4r4 :: Pixman_format_code_t
pattern PIXMAN_a4b4g4r4 = Pixman_format_code_t 268649540

{-| __C declaration:__ @PIXMAN_x4b4g4r4@

    __defined at:__ @pixman.h 1099:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_x4b4g4r4 :: Pixman_format_code_t
pattern PIXMAN_x4b4g4r4 = Pixman_format_code_t 268633156

{-| __C declaration:__ @PIXMAN_a8@

    __defined at:__ @pixman.h 1102:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_a8 :: Pixman_format_code_t
pattern PIXMAN_a8 = Pixman_format_code_t 134316032

{-| __C declaration:__ @PIXMAN_r3g3b2@

    __defined at:__ @pixman.h 1103:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_r3g3b2 :: Pixman_format_code_t
pattern PIXMAN_r3g3b2 = Pixman_format_code_t 134349618

{-| __C declaration:__ @PIXMAN_b2g3r3@

    __defined at:__ @pixman.h 1104:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_b2g3r3 :: Pixman_format_code_t
pattern PIXMAN_b2g3r3 = Pixman_format_code_t 134415154

{-| __C declaration:__ @PIXMAN_a2r2g2b2@

    __defined at:__ @pixman.h 1105:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_a2r2g2b2 :: Pixman_format_code_t
pattern PIXMAN_a2r2g2b2 = Pixman_format_code_t 134357538

{-| __C declaration:__ @PIXMAN_a2b2g2r2@

    __defined at:__ @pixman.h 1106:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_a2b2g2r2 :: Pixman_format_code_t
pattern PIXMAN_a2b2g2r2 = Pixman_format_code_t 134423074

{-| __C declaration:__ @PIXMAN_c8@

    __defined at:__ @pixman.h 1108:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_c8 :: Pixman_format_code_t
pattern PIXMAN_c8 = Pixman_format_code_t 134479872

{-| __C declaration:__ @PIXMAN_g8@

    __defined at:__ @pixman.h 1109:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_g8 :: Pixman_format_code_t
pattern PIXMAN_g8 = Pixman_format_code_t 134545408

{-| __C declaration:__ @PIXMAN_x4a4@

    __defined at:__ @pixman.h 1111:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_x4a4 :: Pixman_format_code_t
pattern PIXMAN_x4a4 = Pixman_format_code_t 134299648

{-| __C declaration:__ @PIXMAN_x4c4@

    __defined at:__ @pixman.h 1113:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_x4c4 :: Pixman_format_code_t
pattern PIXMAN_x4c4 = Pixman_format_code_t 134479872

{-| __C declaration:__ @PIXMAN_x4g4@

    __defined at:__ @pixman.h 1114:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_x4g4 :: Pixman_format_code_t
pattern PIXMAN_x4g4 = Pixman_format_code_t 134545408

{-| __C declaration:__ @PIXMAN_a4@

    __defined at:__ @pixman.h 1117:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_a4 :: Pixman_format_code_t
pattern PIXMAN_a4 = Pixman_format_code_t 67190784

{-| __C declaration:__ @PIXMAN_r1g2b1@

    __defined at:__ @pixman.h 1118:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_r1g2b1 :: Pixman_format_code_t
pattern PIXMAN_r1g2b1 = Pixman_format_code_t 67240225

{-| __C declaration:__ @PIXMAN_b1g2r1@

    __defined at:__ @pixman.h 1119:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_b1g2r1 :: Pixman_format_code_t
pattern PIXMAN_b1g2r1 = Pixman_format_code_t 67305761

{-| __C declaration:__ @PIXMAN_a1r1g1b1@

    __defined at:__ @pixman.h 1120:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_a1r1g1b1 :: Pixman_format_code_t
pattern PIXMAN_a1r1g1b1 = Pixman_format_code_t 67244305

{-| __C declaration:__ @PIXMAN_a1b1g1r1@

    __defined at:__ @pixman.h 1121:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_a1b1g1r1 :: Pixman_format_code_t
pattern PIXMAN_a1b1g1r1 = Pixman_format_code_t 67309841

{-| __C declaration:__ @PIXMAN_c4@

    __defined at:__ @pixman.h 1123:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_c4 :: Pixman_format_code_t
pattern PIXMAN_c4 = Pixman_format_code_t 67371008

{-| __C declaration:__ @PIXMAN_g4@

    __defined at:__ @pixman.h 1124:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_g4 :: Pixman_format_code_t
pattern PIXMAN_g4 = Pixman_format_code_t 67436544

{-| __C declaration:__ @PIXMAN_a1@

    __defined at:__ @pixman.h 1127:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_a1 :: Pixman_format_code_t
pattern PIXMAN_a1 = Pixman_format_code_t 16846848

{-| __C declaration:__ @PIXMAN_g1@

    __defined at:__ @pixman.h 1129:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_g1 :: Pixman_format_code_t
pattern PIXMAN_g1 = Pixman_format_code_t 17104896

{-| __C declaration:__ @PIXMAN_yuy2@

    __defined at:__ @pixman.h 1132:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_yuy2 :: Pixman_format_code_t
pattern PIXMAN_yuy2 = Pixman_format_code_t 268828672

{-| __C declaration:__ @PIXMAN_yv12@

    __defined at:__ @pixman.h 1133:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern PIXMAN_yv12 :: Pixman_format_code_t
pattern PIXMAN_yv12 = Pixman_format_code_t 201785344

{-| __C declaration:__ @enum fcft_log_colorize@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 18:6@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
newtype Fcft_log_colorize = Fcft_log_colorize
  { unwrapFcft_log_colorize :: RIP.CUInt
  }
  deriving stock (Eq, RIP.Generic, Ord)
  deriving newtype (RIP.HasFFIType)

instance Marshal.StaticSize Fcft_log_colorize where

  staticSizeOf = \_ -> (4 :: Int)

  staticAlignment = \_ -> (4 :: Int)

instance Marshal.ReadRaw Fcft_log_colorize where

  readRaw =
    \ptr0 ->
          pure Fcft_log_colorize
      <*> Marshal.readRawByteOff ptr0 (0 :: Int)

instance Marshal.WriteRaw Fcft_log_colorize where

  writeRaw =
    \ptr0 ->
      \s1 ->
        case s1 of
          Fcft_log_colorize unwrapFcft_log_colorize2 ->
            Marshal.writeRawByteOff ptr0 (0 :: Int) unwrapFcft_log_colorize2

deriving via Marshal.EquivStorable Fcft_log_colorize instance RIP.Storable Fcft_log_colorize

deriving via RIP.CUInt instance RIP.Prim Fcft_log_colorize

instance CEnum.CEnum Fcft_log_colorize where

  type CEnumZ Fcft_log_colorize = RIP.CUInt

  toCEnum = Fcft_log_colorize

  fromCEnum = unwrapFcft_log_colorize

  declaredValues =
    \_ ->
      CEnum.declaredValuesFromList [ (0, RIP.singleton "FCFT_LOG_COLORIZE_NEVER")
                                   , (1, RIP.singleton "FCFT_LOG_COLORIZE_ALWAYS")
                                   , (2, RIP.singleton "FCFT_LOG_COLORIZE_AUTO")
                                   ]

  showsUndeclared =
    CEnum.showsWrappedUndeclared "Fcft_log_colorize"

  readPrecUndeclared =
    CEnum.readPrecWrappedUndeclared "Fcft_log_colorize"

  isDeclared = CEnum.seqIsDeclared

  mkDeclared = CEnum.seqMkDeclared

instance CEnum.SequentialCEnum Fcft_log_colorize where

  minDeclaredValue = FCFT_LOG_COLORIZE_NEVER

  maxDeclaredValue = FCFT_LOG_COLORIZE_AUTO

instance Show Fcft_log_colorize where

  showsPrec = CEnum.shows

instance Read Fcft_log_colorize where

  readPrec = CEnum.readPrec

  readList = RIP.readListDefault

  readListPrec = RIP.readListPrecDefault

instance ( ((~) ty) RIP.CUInt
         ) => RIP.HasField "unwrapFcft_log_colorize" (RIP.Ptr Fcft_log_colorize) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"unwrapFcft_log_colorize")

instance HasCField.HasCField Fcft_log_colorize "unwrapFcft_log_colorize" where

  type CFieldType Fcft_log_colorize "unwrapFcft_log_colorize" =
    RIP.CUInt

  offset# = \_ -> \_ -> 0

{-| __C declaration:__ @FCFT_LOG_COLORIZE_NEVER@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 19:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern FCFT_LOG_COLORIZE_NEVER :: Fcft_log_colorize
pattern FCFT_LOG_COLORIZE_NEVER = Fcft_log_colorize 0

{-| __C declaration:__ @FCFT_LOG_COLORIZE_ALWAYS@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 20:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern FCFT_LOG_COLORIZE_ALWAYS :: Fcft_log_colorize
pattern FCFT_LOG_COLORIZE_ALWAYS = Fcft_log_colorize 1

{-| __C declaration:__ @FCFT_LOG_COLORIZE_AUTO@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 21:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern FCFT_LOG_COLORIZE_AUTO :: Fcft_log_colorize
pattern FCFT_LOG_COLORIZE_AUTO = Fcft_log_colorize 2

{-| __C declaration:__ @enum fcft_log_class@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 26:6@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
newtype Fcft_log_class = Fcft_log_class
  { unwrapFcft_log_class :: RIP.CUInt
  }
  deriving stock (Eq, RIP.Generic, Ord)
  deriving newtype (RIP.HasFFIType)

instance Marshal.StaticSize Fcft_log_class where

  staticSizeOf = \_ -> (4 :: Int)

  staticAlignment = \_ -> (4 :: Int)

instance Marshal.ReadRaw Fcft_log_class where

  readRaw =
    \ptr0 ->
          pure Fcft_log_class
      <*> Marshal.readRawByteOff ptr0 (0 :: Int)

instance Marshal.WriteRaw Fcft_log_class where

  writeRaw =
    \ptr0 ->
      \s1 ->
        case s1 of
          Fcft_log_class unwrapFcft_log_class2 ->
            Marshal.writeRawByteOff ptr0 (0 :: Int) unwrapFcft_log_class2

deriving via Marshal.EquivStorable Fcft_log_class instance RIP.Storable Fcft_log_class

deriving via RIP.CUInt instance RIP.Prim Fcft_log_class

instance CEnum.CEnum Fcft_log_class where

  type CEnumZ Fcft_log_class = RIP.CUInt

  toCEnum = Fcft_log_class

  fromCEnum = unwrapFcft_log_class

  declaredValues =
    \_ ->
      CEnum.declaredValuesFromList [ (0, RIP.singleton "FCFT_LOG_CLASS_NONE")
                                   , (1, RIP.singleton "FCFT_LOG_CLASS_ERROR")
                                   , (2, RIP.singleton "FCFT_LOG_CLASS_WARNING")
                                   , (3, RIP.singleton "FCFT_LOG_CLASS_INFO")
                                   , (4, RIP.singleton "FCFT_LOG_CLASS_DEBUG")
                                   ]

  showsUndeclared =
    CEnum.showsWrappedUndeclared "Fcft_log_class"

  readPrecUndeclared =
    CEnum.readPrecWrappedUndeclared "Fcft_log_class"

  isDeclared = CEnum.seqIsDeclared

  mkDeclared = CEnum.seqMkDeclared

instance CEnum.SequentialCEnum Fcft_log_class where

  minDeclaredValue = FCFT_LOG_CLASS_NONE

  maxDeclaredValue = FCFT_LOG_CLASS_DEBUG

instance Show Fcft_log_class where

  showsPrec = CEnum.shows

instance Read Fcft_log_class where

  readPrec = CEnum.readPrec

  readList = RIP.readListDefault

  readListPrec = RIP.readListPrecDefault

instance ( ((~) ty) RIP.CUInt
         ) => RIP.HasField "unwrapFcft_log_class" (RIP.Ptr Fcft_log_class) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"unwrapFcft_log_class")

instance HasCField.HasCField Fcft_log_class "unwrapFcft_log_class" where

  type CFieldType Fcft_log_class "unwrapFcft_log_class" =
    RIP.CUInt

  offset# = \_ -> \_ -> 0

{-| __C declaration:__ @FCFT_LOG_CLASS_NONE@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 27:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern FCFT_LOG_CLASS_NONE :: Fcft_log_class
pattern FCFT_LOG_CLASS_NONE = Fcft_log_class 0

{-| __C declaration:__ @FCFT_LOG_CLASS_ERROR@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 28:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern FCFT_LOG_CLASS_ERROR :: Fcft_log_class
pattern FCFT_LOG_CLASS_ERROR = Fcft_log_class 1

{-| __C declaration:__ @FCFT_LOG_CLASS_WARNING@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 29:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern FCFT_LOG_CLASS_WARNING :: Fcft_log_class
pattern FCFT_LOG_CLASS_WARNING = Fcft_log_class 2

{-| __C declaration:__ @FCFT_LOG_CLASS_INFO@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 30:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern FCFT_LOG_CLASS_INFO :: Fcft_log_class
pattern FCFT_LOG_CLASS_INFO = Fcft_log_class 3

{-| __C declaration:__ @FCFT_LOG_CLASS_DEBUG@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 31:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern FCFT_LOG_CLASS_DEBUG :: Fcft_log_class
pattern FCFT_LOG_CLASS_DEBUG = Fcft_log_class 4

{-| __C declaration:__ @enum fcft_subpixel@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 46:6@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
newtype Fcft_subpixel = Fcft_subpixel
  { unwrapFcft_subpixel :: RIP.CUInt
  }
  deriving stock (Eq, RIP.Generic, Ord)
  deriving newtype (RIP.HasFFIType)

instance Marshal.StaticSize Fcft_subpixel where

  staticSizeOf = \_ -> (4 :: Int)

  staticAlignment = \_ -> (4 :: Int)

instance Marshal.ReadRaw Fcft_subpixel where

  readRaw =
    \ptr0 ->
          pure Fcft_subpixel
      <*> Marshal.readRawByteOff ptr0 (0 :: Int)

instance Marshal.WriteRaw Fcft_subpixel where

  writeRaw =
    \ptr0 ->
      \s1 ->
        case s1 of
          Fcft_subpixel unwrapFcft_subpixel2 ->
            Marshal.writeRawByteOff ptr0 (0 :: Int) unwrapFcft_subpixel2

deriving via Marshal.EquivStorable Fcft_subpixel instance RIP.Storable Fcft_subpixel

deriving via RIP.CUInt instance RIP.Prim Fcft_subpixel

instance CEnum.CEnum Fcft_subpixel where

  type CEnumZ Fcft_subpixel = RIP.CUInt

  toCEnum = Fcft_subpixel

  fromCEnum = unwrapFcft_subpixel

  declaredValues =
    \_ ->
      CEnum.declaredValuesFromList [ (0, RIP.singleton "FCFT_SUBPIXEL_DEFAULT")
                                   , (1, RIP.singleton "FCFT_SUBPIXEL_NONE")
                                   , (2, RIP.singleton "FCFT_SUBPIXEL_HORIZONTAL_RGB")
                                   , (3, RIP.singleton "FCFT_SUBPIXEL_HORIZONTAL_BGR")
                                   , (4, RIP.singleton "FCFT_SUBPIXEL_VERTICAL_RGB")
                                   , (5, RIP.singleton "FCFT_SUBPIXEL_VERTICAL_BGR")
                                   ]

  showsUndeclared =
    CEnum.showsWrappedUndeclared "Fcft_subpixel"

  readPrecUndeclared =
    CEnum.readPrecWrappedUndeclared "Fcft_subpixel"

  isDeclared = CEnum.seqIsDeclared

  mkDeclared = CEnum.seqMkDeclared

instance CEnum.SequentialCEnum Fcft_subpixel where

  minDeclaredValue = FCFT_SUBPIXEL_DEFAULT

  maxDeclaredValue = FCFT_SUBPIXEL_VERTICAL_BGR

instance Show Fcft_subpixel where

  showsPrec = CEnum.shows

instance Read Fcft_subpixel where

  readPrec = CEnum.readPrec

  readList = RIP.readListDefault

  readListPrec = RIP.readListPrecDefault

instance ( ((~) ty) RIP.CUInt
         ) => RIP.HasField "unwrapFcft_subpixel" (RIP.Ptr Fcft_subpixel) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"unwrapFcft_subpixel")

instance HasCField.HasCField Fcft_subpixel "unwrapFcft_subpixel" where

  type CFieldType Fcft_subpixel "unwrapFcft_subpixel" =
    RIP.CUInt

  offset# = \_ -> \_ -> 0

{-| __C declaration:__ @FCFT_SUBPIXEL_DEFAULT@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 47:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern FCFT_SUBPIXEL_DEFAULT :: Fcft_subpixel
pattern FCFT_SUBPIXEL_DEFAULT = Fcft_subpixel 0

{-| __C declaration:__ @FCFT_SUBPIXEL_NONE@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 48:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern FCFT_SUBPIXEL_NONE :: Fcft_subpixel
pattern FCFT_SUBPIXEL_NONE = Fcft_subpixel 1

{-| __C declaration:__ @FCFT_SUBPIXEL_HORIZONTAL_RGB@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 49:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern FCFT_SUBPIXEL_HORIZONTAL_RGB :: Fcft_subpixel
pattern FCFT_SUBPIXEL_HORIZONTAL_RGB = Fcft_subpixel 2

{-| __C declaration:__ @FCFT_SUBPIXEL_HORIZONTAL_BGR@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 50:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern FCFT_SUBPIXEL_HORIZONTAL_BGR :: Fcft_subpixel
pattern FCFT_SUBPIXEL_HORIZONTAL_BGR = Fcft_subpixel 3

{-| __C declaration:__ @FCFT_SUBPIXEL_VERTICAL_RGB@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 51:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern FCFT_SUBPIXEL_VERTICAL_RGB :: Fcft_subpixel
pattern FCFT_SUBPIXEL_VERTICAL_RGB = Fcft_subpixel 4

{-| __C declaration:__ @FCFT_SUBPIXEL_VERTICAL_BGR@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 52:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern FCFT_SUBPIXEL_VERTICAL_BGR :: Fcft_subpixel
pattern FCFT_SUBPIXEL_VERTICAL_BGR = Fcft_subpixel 5

{-| __C declaration:__ @struct \@fcft_font_max_advance@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 64:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
data Fcft_font_max_advance = Fcft_font_max_advance
  { fcft_font_max_advance_x :: RIP.CInt
    {- ^ __C declaration:__ @x@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 65:13@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  , fcft_font_max_advance_y :: RIP.CInt
    {- ^ __C declaration:__ @y@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 66:13@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  }
  deriving stock (Eq, RIP.Generic, Show)

instance Marshal.StaticSize Fcft_font_max_advance where

  staticSizeOf = \_ -> (8 :: Int)

  staticAlignment = \_ -> (4 :: Int)

instance Marshal.ReadRaw Fcft_font_max_advance where

  readRaw =
    \ptr0 ->
          pure Fcft_font_max_advance
      <*> HasCField.readRaw (RIP.Proxy @"fcft_font_max_advance_x") ptr0
      <*> HasCField.readRaw (RIP.Proxy @"fcft_font_max_advance_y") ptr0

instance Marshal.WriteRaw Fcft_font_max_advance where

  writeRaw =
    \ptr0 ->
      \s1 ->
        case s1 of
          Fcft_font_max_advance fcft_font_max_advance_x2 fcft_font_max_advance_y3 ->
               HasCField.writeRaw (RIP.Proxy @"fcft_font_max_advance_x") ptr0 fcft_font_max_advance_x2
            >> HasCField.writeRaw (RIP.Proxy @"fcft_font_max_advance_y") ptr0 fcft_font_max_advance_y3

deriving via Marshal.EquivStorable Fcft_font_max_advance instance RIP.Storable Fcft_font_max_advance

instance HasCField.HasCField Fcft_font_max_advance "fcft_font_max_advance_x" where

  type CFieldType Fcft_font_max_advance "fcft_font_max_advance_x" =
    RIP.CInt

  offset# = \_ -> \_ -> 0

instance ( ((~) ty) RIP.CInt
         ) => RIP.HasField "fcft_font_max_advance_x" (RIP.Ptr Fcft_font_max_advance) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_font_max_advance_x")

instance HasCField.HasCField Fcft_font_max_advance "fcft_font_max_advance_y" where

  type CFieldType Fcft_font_max_advance "fcft_font_max_advance_y" =
    RIP.CInt

  offset# = \_ -> \_ -> 4

instance ( ((~) ty) RIP.CInt
         ) => RIP.HasField "fcft_font_max_advance_y" (RIP.Ptr Fcft_font_max_advance) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_font_max_advance_y")

{-| __C declaration:__ @struct \@fcft_font_underline@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 69:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
data Fcft_font_underline = Fcft_font_underline
  { fcft_font_underline_position :: RIP.CInt
    {- ^ __C declaration:__ @position@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 70:13@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  , fcft_font_underline_thickness :: RIP.CInt
    {- ^ __C declaration:__ @thickness@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 71:13@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  }
  deriving stock (Eq, RIP.Generic, Show)

instance Marshal.StaticSize Fcft_font_underline where

  staticSizeOf = \_ -> (8 :: Int)

  staticAlignment = \_ -> (4 :: Int)

instance Marshal.ReadRaw Fcft_font_underline where

  readRaw =
    \ptr0 ->
          pure Fcft_font_underline
      <*> HasCField.readRaw (RIP.Proxy @"fcft_font_underline_position") ptr0
      <*> HasCField.readRaw (RIP.Proxy @"fcft_font_underline_thickness") ptr0

instance Marshal.WriteRaw Fcft_font_underline where

  writeRaw =
    \ptr0 ->
      \s1 ->
        case s1 of
          Fcft_font_underline
            fcft_font_underline_position2
            fcft_font_underline_thickness3 ->
                 HasCField.writeRaw (RIP.Proxy @"fcft_font_underline_position") ptr0 fcft_font_underline_position2
              >> HasCField.writeRaw (RIP.Proxy @"fcft_font_underline_thickness") ptr0 fcft_font_underline_thickness3

deriving via Marshal.EquivStorable Fcft_font_underline instance RIP.Storable Fcft_font_underline

instance HasCField.HasCField Fcft_font_underline "fcft_font_underline_position" where

  type CFieldType Fcft_font_underline "fcft_font_underline_position" =
    RIP.CInt

  offset# = \_ -> \_ -> 0

instance ( ((~) ty) RIP.CInt
         ) => RIP.HasField "fcft_font_underline_position" (RIP.Ptr Fcft_font_underline) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_font_underline_position")

instance HasCField.HasCField Fcft_font_underline "fcft_font_underline_thickness" where

  type CFieldType Fcft_font_underline "fcft_font_underline_thickness" =
    RIP.CInt

  offset# = \_ -> \_ -> 4

instance ( ((~) ty) RIP.CInt
         ) => RIP.HasField "fcft_font_underline_thickness" (RIP.Ptr Fcft_font_underline) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_font_underline_thickness")

{-| __C declaration:__ @struct \@fcft_font_strikeout@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 74:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
data Fcft_font_strikeout = Fcft_font_strikeout
  { fcft_font_strikeout_position :: RIP.CInt
    {- ^ __C declaration:__ @position@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 75:13@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  , fcft_font_strikeout_thickness :: RIP.CInt
    {- ^ __C declaration:__ @thickness@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 76:13@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  }
  deriving stock (Eq, RIP.Generic, Show)

instance Marshal.StaticSize Fcft_font_strikeout where

  staticSizeOf = \_ -> (8 :: Int)

  staticAlignment = \_ -> (4 :: Int)

instance Marshal.ReadRaw Fcft_font_strikeout where

  readRaw =
    \ptr0 ->
          pure Fcft_font_strikeout
      <*> HasCField.readRaw (RIP.Proxy @"fcft_font_strikeout_position") ptr0
      <*> HasCField.readRaw (RIP.Proxy @"fcft_font_strikeout_thickness") ptr0

instance Marshal.WriteRaw Fcft_font_strikeout where

  writeRaw =
    \ptr0 ->
      \s1 ->
        case s1 of
          Fcft_font_strikeout
            fcft_font_strikeout_position2
            fcft_font_strikeout_thickness3 ->
                 HasCField.writeRaw (RIP.Proxy @"fcft_font_strikeout_position") ptr0 fcft_font_strikeout_position2
              >> HasCField.writeRaw (RIP.Proxy @"fcft_font_strikeout_thickness") ptr0 fcft_font_strikeout_thickness3

deriving via Marshal.EquivStorable Fcft_font_strikeout instance RIP.Storable Fcft_font_strikeout

instance HasCField.HasCField Fcft_font_strikeout "fcft_font_strikeout_position" where

  type CFieldType Fcft_font_strikeout "fcft_font_strikeout_position" =
    RIP.CInt

  offset# = \_ -> \_ -> 0

instance ( ((~) ty) RIP.CInt
         ) => RIP.HasField "fcft_font_strikeout_position" (RIP.Ptr Fcft_font_strikeout) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_font_strikeout_position")

instance HasCField.HasCField Fcft_font_strikeout "fcft_font_strikeout_thickness" where

  type CFieldType Fcft_font_strikeout "fcft_font_strikeout_thickness" =
    RIP.CInt

  offset# = \_ -> \_ -> 4

instance ( ((~) ty) RIP.CInt
         ) => RIP.HasField "fcft_font_strikeout_thickness" (RIP.Ptr Fcft_font_strikeout) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_font_strikeout_thickness")

{-| __C declaration:__ @struct fcft_font@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 55:8@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
data Fcft_font = Fcft_font
  { fcft_font_name :: PtrConst.PtrConst RIP.CChar
    {- ^ __C declaration:__ @name@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 56:17@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  , fcft_font_height :: RIP.CInt
    {- ^ __C declaration:__ @height@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 59:9@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  , fcft_font_descent :: RIP.CInt
    {- ^ __C declaration:__ @descent@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 60:9@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  , fcft_font_ascent :: RIP.CInt
    {- ^ __C declaration:__ @ascent@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 61:9@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  , fcft_font_max_advance :: Fcft_font_max_advance
    {- ^ __C declaration:__ @max_advance@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 67:7@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  , fcft_font_underline :: Fcft_font_underline
    {- ^ __C declaration:__ @underline@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 72:7@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  , fcft_font_strikeout :: Fcft_font_strikeout
    {- ^ __C declaration:__ @strikeout@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 77:7@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  , fcft_font_antialias :: HsBindgen.Runtime.LibC.CBool
    {- ^ __C declaration:__ @antialias@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 79:10@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  , fcft_font_subpixel :: Fcft_subpixel
    {- ^ __C declaration:__ @subpixel@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 83:24@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  }
  deriving stock (Eq, RIP.Generic, Show)

instance Marshal.StaticSize Fcft_font where

  staticSizeOf = \_ -> (56 :: Int)

  staticAlignment = \_ -> (8 :: Int)

instance Marshal.ReadRaw Fcft_font where

  readRaw =
    \ptr0 ->
          pure Fcft_font
      <*> HasCField.readRaw (RIP.Proxy @"fcft_font_name") ptr0
      <*> HasCField.readRaw (RIP.Proxy @"fcft_font_height") ptr0
      <*> HasCField.readRaw (RIP.Proxy @"fcft_font_descent") ptr0
      <*> HasCField.readRaw (RIP.Proxy @"fcft_font_ascent") ptr0
      <*> HasCField.readRaw (RIP.Proxy @"fcft_font_max_advance") ptr0
      <*> HasCField.readRaw (RIP.Proxy @"fcft_font_underline") ptr0
      <*> HasCField.readRaw (RIP.Proxy @"fcft_font_strikeout") ptr0
      <*> HasCField.readRaw (RIP.Proxy @"fcft_font_antialias") ptr0
      <*> HasCField.readRaw (RIP.Proxy @"fcft_font_subpixel") ptr0

instance Marshal.WriteRaw Fcft_font where

  writeRaw =
    \ptr0 ->
      \s1 ->
        case s1 of
          Fcft_font
            fcft_font_name2
            fcft_font_height3
            fcft_font_descent4
            fcft_font_ascent5
            fcft_font_max_advance6
            fcft_font_underline7
            fcft_font_strikeout8
            fcft_font_antialias9
            fcft_font_subpixel10 ->
                 HasCField.writeRaw (RIP.Proxy @"fcft_font_name") ptr0 fcft_font_name2
              >> HasCField.writeRaw (RIP.Proxy @"fcft_font_height") ptr0 fcft_font_height3
              >> HasCField.writeRaw (RIP.Proxy @"fcft_font_descent") ptr0 fcft_font_descent4
              >> HasCField.writeRaw (RIP.Proxy @"fcft_font_ascent") ptr0 fcft_font_ascent5
              >> HasCField.writeRaw (RIP.Proxy @"fcft_font_max_advance") ptr0 fcft_font_max_advance6
              >> HasCField.writeRaw (RIP.Proxy @"fcft_font_underline") ptr0 fcft_font_underline7
              >> HasCField.writeRaw (RIP.Proxy @"fcft_font_strikeout") ptr0 fcft_font_strikeout8
              >> HasCField.writeRaw (RIP.Proxy @"fcft_font_antialias") ptr0 fcft_font_antialias9
              >> HasCField.writeRaw (RIP.Proxy @"fcft_font_subpixel") ptr0 fcft_font_subpixel10

deriving via Marshal.EquivStorable Fcft_font instance RIP.Storable Fcft_font

instance HasCField.HasCField Fcft_font "fcft_font_name" where

  type CFieldType Fcft_font "fcft_font_name" =
    PtrConst.PtrConst RIP.CChar

  offset# = \_ -> \_ -> 0

instance ( ((~) ty) (PtrConst.PtrConst RIP.CChar)
         ) => RIP.HasField "fcft_font_name" (RIP.Ptr Fcft_font) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_font_name")

instance HasCField.HasCField Fcft_font "fcft_font_height" where

  type CFieldType Fcft_font "fcft_font_height" =
    RIP.CInt

  offset# = \_ -> \_ -> 8

instance ( ((~) ty) RIP.CInt
         ) => RIP.HasField "fcft_font_height" (RIP.Ptr Fcft_font) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_font_height")

instance HasCField.HasCField Fcft_font "fcft_font_descent" where

  type CFieldType Fcft_font "fcft_font_descent" =
    RIP.CInt

  offset# = \_ -> \_ -> 12

instance ( ((~) ty) RIP.CInt
         ) => RIP.HasField "fcft_font_descent" (RIP.Ptr Fcft_font) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_font_descent")

instance HasCField.HasCField Fcft_font "fcft_font_ascent" where

  type CFieldType Fcft_font "fcft_font_ascent" =
    RIP.CInt

  offset# = \_ -> \_ -> 16

instance ( ((~) ty) RIP.CInt
         ) => RIP.HasField "fcft_font_ascent" (RIP.Ptr Fcft_font) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_font_ascent")

instance HasCField.HasCField Fcft_font "fcft_font_max_advance" where

  type CFieldType Fcft_font "fcft_font_max_advance" =
    Fcft_font_max_advance

  offset# = \_ -> \_ -> 20

instance ( ((~) ty) Fcft_font_max_advance
         ) => RIP.HasField "fcft_font_max_advance" (RIP.Ptr Fcft_font) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_font_max_advance")

instance HasCField.HasCField Fcft_font "fcft_font_underline" where

  type CFieldType Fcft_font "fcft_font_underline" =
    Fcft_font_underline

  offset# = \_ -> \_ -> 28

instance ( ((~) ty) Fcft_font_underline
         ) => RIP.HasField "fcft_font_underline" (RIP.Ptr Fcft_font) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_font_underline")

instance HasCField.HasCField Fcft_font "fcft_font_strikeout" where

  type CFieldType Fcft_font "fcft_font_strikeout" =
    Fcft_font_strikeout

  offset# = \_ -> \_ -> 36

instance ( ((~) ty) Fcft_font_strikeout
         ) => RIP.HasField "fcft_font_strikeout" (RIP.Ptr Fcft_font) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_font_strikeout")

instance HasCField.HasCField Fcft_font "fcft_font_antialias" where

  type CFieldType Fcft_font "fcft_font_antialias" =
    HsBindgen.Runtime.LibC.CBool

  offset# = \_ -> \_ -> 44

instance ( ((~) ty) HsBindgen.Runtime.LibC.CBool
         ) => RIP.HasField "fcft_font_antialias" (RIP.Ptr Fcft_font) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_font_antialias")

instance HasCField.HasCField Fcft_font "fcft_font_subpixel" where

  type CFieldType Fcft_font "fcft_font_subpixel" =
    Fcft_subpixel

  offset# = \_ -> \_ -> 48

instance ( ((~) ty) Fcft_subpixel
         ) => RIP.HasField "fcft_font_subpixel" (RIP.Ptr Fcft_font) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_font_subpixel")

{-| __C declaration:__ @enum fcft_capabilities@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 87:6@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
newtype Fcft_capabilities = Fcft_capabilities
  { unwrapFcft_capabilities :: RIP.CUInt
  }
  deriving stock (Eq, RIP.Generic, Ord)
  deriving newtype (RIP.HasFFIType)

instance Marshal.StaticSize Fcft_capabilities where

  staticSizeOf = \_ -> (4 :: Int)

  staticAlignment = \_ -> (4 :: Int)

instance Marshal.ReadRaw Fcft_capabilities where

  readRaw =
    \ptr0 ->
          pure Fcft_capabilities
      <*> Marshal.readRawByteOff ptr0 (0 :: Int)

instance Marshal.WriteRaw Fcft_capabilities where

  writeRaw =
    \ptr0 ->
      \s1 ->
        case s1 of
          Fcft_capabilities unwrapFcft_capabilities2 ->
            Marshal.writeRawByteOff ptr0 (0 :: Int) unwrapFcft_capabilities2

deriving via Marshal.EquivStorable Fcft_capabilities instance RIP.Storable Fcft_capabilities

deriving via RIP.CUInt instance RIP.Prim Fcft_capabilities

instance CEnum.CEnum Fcft_capabilities where

  type CEnumZ Fcft_capabilities = RIP.CUInt

  toCEnum = Fcft_capabilities

  fromCEnum = unwrapFcft_capabilities

  declaredValues =
    \_ ->
      CEnum.declaredValuesFromList [ (1, RIP.singleton "FCFT_CAPABILITY_GRAPHEME_SHAPING")
                                   , (2, RIP.singleton "FCFT_CAPABILITY_TEXT_RUN_SHAPING")
                                   , (4, RIP.singleton "FCFT_CAPABILITY_SVG")
                                   ]

  showsUndeclared =
    CEnum.showsWrappedUndeclared "Fcft_capabilities"

  readPrecUndeclared =
    CEnum.readPrecWrappedUndeclared "Fcft_capabilities"

instance Show Fcft_capabilities where

  showsPrec = CEnum.shows

instance Read Fcft_capabilities where

  readPrec = CEnum.readPrec

  readList = RIP.readListDefault

  readListPrec = RIP.readListPrecDefault

instance ( ((~) ty) RIP.CUInt
         ) => RIP.HasField "unwrapFcft_capabilities" (RIP.Ptr Fcft_capabilities) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"unwrapFcft_capabilities")

instance HasCField.HasCField Fcft_capabilities "unwrapFcft_capabilities" where

  type CFieldType Fcft_capabilities "unwrapFcft_capabilities" =
    RIP.CUInt

  offset# = \_ -> \_ -> 0

{-| __C declaration:__ @FCFT_CAPABILITY_GRAPHEME_SHAPING@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 88:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern FCFT_CAPABILITY_GRAPHEME_SHAPING :: Fcft_capabilities
pattern FCFT_CAPABILITY_GRAPHEME_SHAPING = Fcft_capabilities 1

{-| __C declaration:__ @FCFT_CAPABILITY_TEXT_RUN_SHAPING@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 89:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern FCFT_CAPABILITY_TEXT_RUN_SHAPING :: Fcft_capabilities
pattern FCFT_CAPABILITY_TEXT_RUN_SHAPING = Fcft_capabilities 2

{-| __C declaration:__ @FCFT_CAPABILITY_SVG@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 90:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern FCFT_CAPABILITY_SVG :: Fcft_capabilities
pattern FCFT_CAPABILITY_SVG = Fcft_capabilities 4

{-| __C declaration:__ @struct \@fcft_glyph_advance@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 114:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
data Fcft_glyph_advance = Fcft_glyph_advance
  { fcft_glyph_advance_x :: RIP.CInt
    {- ^ __C declaration:__ @x@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 115:13@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  , fcft_glyph_advance_y :: RIP.CInt
    {- ^ __C declaration:__ @y@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 116:13@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  }
  deriving stock (Eq, RIP.Generic, Show)

instance Marshal.StaticSize Fcft_glyph_advance where

  staticSizeOf = \_ -> (8 :: Int)

  staticAlignment = \_ -> (4 :: Int)

instance Marshal.ReadRaw Fcft_glyph_advance where

  readRaw =
    \ptr0 ->
          pure Fcft_glyph_advance
      <*> HasCField.readRaw (RIP.Proxy @"fcft_glyph_advance_x") ptr0
      <*> HasCField.readRaw (RIP.Proxy @"fcft_glyph_advance_y") ptr0

instance Marshal.WriteRaw Fcft_glyph_advance where

  writeRaw =
    \ptr0 ->
      \s1 ->
        case s1 of
          Fcft_glyph_advance fcft_glyph_advance_x2 fcft_glyph_advance_y3 ->
               HasCField.writeRaw (RIP.Proxy @"fcft_glyph_advance_x") ptr0 fcft_glyph_advance_x2
            >> HasCField.writeRaw (RIP.Proxy @"fcft_glyph_advance_y") ptr0 fcft_glyph_advance_y3

deriving via Marshal.EquivStorable Fcft_glyph_advance instance RIP.Storable Fcft_glyph_advance

instance HasCField.HasCField Fcft_glyph_advance "fcft_glyph_advance_x" where

  type CFieldType Fcft_glyph_advance "fcft_glyph_advance_x" =
    RIP.CInt

  offset# = \_ -> \_ -> 0

instance ( ((~) ty) RIP.CInt
         ) => RIP.HasField "fcft_glyph_advance_x" (RIP.Ptr Fcft_glyph_advance) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_glyph_advance_x")

instance HasCField.HasCField Fcft_glyph_advance "fcft_glyph_advance_y" where

  type CFieldType Fcft_glyph_advance "fcft_glyph_advance_y" =
    RIP.CInt

  offset# = \_ -> \_ -> 4

instance ( ((~) ty) RIP.CInt
         ) => RIP.HasField "fcft_glyph_advance_y" (RIP.Ptr Fcft_glyph_advance) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_glyph_advance_y")

{-| __C declaration:__ @struct fcft_glyph@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 102:8@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
data Fcft_glyph = Fcft_glyph
  { fcft_glyph_cp :: HsBindgen.Runtime.LibC.Word32
    {- ^ __C declaration:__ @cp@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 103:14@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  , fcft_glyph_cols :: RIP.CInt
    {- ^ __C declaration:__ @cols@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 104:9@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  , fcft_glyph_font_name :: PtrConst.PtrConst RIP.CChar
    {- ^ __C declaration:__ @font_name@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 106:17@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  , fcft_glyph_pix :: RIP.Ptr Pixman_image_t
    {- ^ __C declaration:__ @pix@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 107:21@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  , fcft_glyph_x :: RIP.CInt
    {- ^ __C declaration:__ @x@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 109:9@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  , fcft_glyph_y :: RIP.CInt
    {- ^ __C declaration:__ @y@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 110:9@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  , fcft_glyph_width :: RIP.CInt
    {- ^ __C declaration:__ @width@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 111:9@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  , fcft_glyph_height :: RIP.CInt
    {- ^ __C declaration:__ @height@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 112:9@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  , fcft_glyph_advance :: Fcft_glyph_advance
    {- ^ __C declaration:__ @advance@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 117:7@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  , fcft_glyph_is_color_glyph :: HsBindgen.Runtime.LibC.CBool
    {- ^ __C declaration:__ @is_color_glyph@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 119:10@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  }
  deriving stock (Eq, RIP.Generic, Show)

instance Marshal.StaticSize Fcft_glyph where

  staticSizeOf = \_ -> (56 :: Int)

  staticAlignment = \_ -> (8 :: Int)

instance Marshal.ReadRaw Fcft_glyph where

  readRaw =
    \ptr0 ->
          pure Fcft_glyph
      <*> HasCField.readRaw (RIP.Proxy @"fcft_glyph_cp") ptr0
      <*> HasCField.readRaw (RIP.Proxy @"fcft_glyph_cols") ptr0
      <*> HasCField.readRaw (RIP.Proxy @"fcft_glyph_font_name") ptr0
      <*> HasCField.readRaw (RIP.Proxy @"fcft_glyph_pix") ptr0
      <*> HasCField.readRaw (RIP.Proxy @"fcft_glyph_x") ptr0
      <*> HasCField.readRaw (RIP.Proxy @"fcft_glyph_y") ptr0
      <*> HasCField.readRaw (RIP.Proxy @"fcft_glyph_width") ptr0
      <*> HasCField.readRaw (RIP.Proxy @"fcft_glyph_height") ptr0
      <*> HasCField.readRaw (RIP.Proxy @"fcft_glyph_advance") ptr0
      <*> HasCField.readRaw (RIP.Proxy @"fcft_glyph_is_color_glyph") ptr0

instance Marshal.WriteRaw Fcft_glyph where

  writeRaw =
    \ptr0 ->
      \s1 ->
        case s1 of
          Fcft_glyph
            fcft_glyph_cp2
            fcft_glyph_cols3
            fcft_glyph_font_name4
            fcft_glyph_pix5
            fcft_glyph_x6
            fcft_glyph_y7
            fcft_glyph_width8
            fcft_glyph_height9
            fcft_glyph_advance10
            fcft_glyph_is_color_glyph11 ->
                 HasCField.writeRaw (RIP.Proxy @"fcft_glyph_cp") ptr0 fcft_glyph_cp2
              >> HasCField.writeRaw (RIP.Proxy @"fcft_glyph_cols") ptr0 fcft_glyph_cols3
              >> HasCField.writeRaw (RIP.Proxy @"fcft_glyph_font_name") ptr0 fcft_glyph_font_name4
              >> HasCField.writeRaw (RIP.Proxy @"fcft_glyph_pix") ptr0 fcft_glyph_pix5
              >> HasCField.writeRaw (RIP.Proxy @"fcft_glyph_x") ptr0 fcft_glyph_x6
              >> HasCField.writeRaw (RIP.Proxy @"fcft_glyph_y") ptr0 fcft_glyph_y7
              >> HasCField.writeRaw (RIP.Proxy @"fcft_glyph_width") ptr0 fcft_glyph_width8
              >> HasCField.writeRaw (RIP.Proxy @"fcft_glyph_height") ptr0 fcft_glyph_height9
              >> HasCField.writeRaw (RIP.Proxy @"fcft_glyph_advance") ptr0 fcft_glyph_advance10
              >> HasCField.writeRaw (RIP.Proxy @"fcft_glyph_is_color_glyph") ptr0 fcft_glyph_is_color_glyph11

deriving via Marshal.EquivStorable Fcft_glyph instance RIP.Storable Fcft_glyph

instance HasCField.HasCField Fcft_glyph "fcft_glyph_cp" where

  type CFieldType Fcft_glyph "fcft_glyph_cp" =
    HsBindgen.Runtime.LibC.Word32

  offset# = \_ -> \_ -> 0

instance ( ((~) ty) HsBindgen.Runtime.LibC.Word32
         ) => RIP.HasField "fcft_glyph_cp" (RIP.Ptr Fcft_glyph) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_glyph_cp")

instance HasCField.HasCField Fcft_glyph "fcft_glyph_cols" where

  type CFieldType Fcft_glyph "fcft_glyph_cols" =
    RIP.CInt

  offset# = \_ -> \_ -> 4

instance ( ((~) ty) RIP.CInt
         ) => RIP.HasField "fcft_glyph_cols" (RIP.Ptr Fcft_glyph) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_glyph_cols")

instance HasCField.HasCField Fcft_glyph "fcft_glyph_font_name" where

  type CFieldType Fcft_glyph "fcft_glyph_font_name" =
    PtrConst.PtrConst RIP.CChar

  offset# = \_ -> \_ -> 8

instance ( ((~) ty) (PtrConst.PtrConst RIP.CChar)
         ) => RIP.HasField "fcft_glyph_font_name" (RIP.Ptr Fcft_glyph) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_glyph_font_name")

instance HasCField.HasCField Fcft_glyph "fcft_glyph_pix" where

  type CFieldType Fcft_glyph "fcft_glyph_pix" =
    RIP.Ptr Pixman_image_t

  offset# = \_ -> \_ -> 16

instance ( ((~) ty) (RIP.Ptr Pixman_image_t)
         ) => RIP.HasField "fcft_glyph_pix" (RIP.Ptr Fcft_glyph) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_glyph_pix")

instance HasCField.HasCField Fcft_glyph "fcft_glyph_x" where

  type CFieldType Fcft_glyph "fcft_glyph_x" = RIP.CInt

  offset# = \_ -> \_ -> 24

instance ( ((~) ty) RIP.CInt
         ) => RIP.HasField "fcft_glyph_x" (RIP.Ptr Fcft_glyph) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_glyph_x")

instance HasCField.HasCField Fcft_glyph "fcft_glyph_y" where

  type CFieldType Fcft_glyph "fcft_glyph_y" = RIP.CInt

  offset# = \_ -> \_ -> 28

instance ( ((~) ty) RIP.CInt
         ) => RIP.HasField "fcft_glyph_y" (RIP.Ptr Fcft_glyph) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_glyph_y")

instance HasCField.HasCField Fcft_glyph "fcft_glyph_width" where

  type CFieldType Fcft_glyph "fcft_glyph_width" =
    RIP.CInt

  offset# = \_ -> \_ -> 32

instance ( ((~) ty) RIP.CInt
         ) => RIP.HasField "fcft_glyph_width" (RIP.Ptr Fcft_glyph) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_glyph_width")

instance HasCField.HasCField Fcft_glyph "fcft_glyph_height" where

  type CFieldType Fcft_glyph "fcft_glyph_height" =
    RIP.CInt

  offset# = \_ -> \_ -> 36

instance ( ((~) ty) RIP.CInt
         ) => RIP.HasField "fcft_glyph_height" (RIP.Ptr Fcft_glyph) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_glyph_height")

instance HasCField.HasCField Fcft_glyph "fcft_glyph_advance" where

  type CFieldType Fcft_glyph "fcft_glyph_advance" =
    Fcft_glyph_advance

  offset# = \_ -> \_ -> 40

instance ( ((~) ty) Fcft_glyph_advance
         ) => RIP.HasField "fcft_glyph_advance" (RIP.Ptr Fcft_glyph) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_glyph_advance")

instance HasCField.HasCField Fcft_glyph "fcft_glyph_is_color_glyph" where

  type CFieldType Fcft_glyph "fcft_glyph_is_color_glyph" =
    HsBindgen.Runtime.LibC.CBool

  offset# = \_ -> \_ -> 48

instance ( ((~) ty) HsBindgen.Runtime.LibC.CBool
         ) => RIP.HasField "fcft_glyph_is_color_glyph" (RIP.Ptr Fcft_glyph) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_glyph_is_color_glyph")

{-| __C declaration:__ @struct fcft_grapheme@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 127:8@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
data Fcft_grapheme = Fcft_grapheme
  { fcft_grapheme_cols :: RIP.CInt
    {- ^ __C declaration:__ @cols@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 128:9@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  , fcft_grapheme_count :: HsBindgen.Runtime.LibC.CSize
    {- ^ __C declaration:__ @count@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 130:12@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  , fcft_grapheme_glyphs :: RIP.Ptr (PtrConst.PtrConst Fcft_glyph)
    {- ^ __C declaration:__ @glyphs@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 131:31@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  }
  deriving stock (Eq, RIP.Generic, Show)

instance Marshal.StaticSize Fcft_grapheme where

  staticSizeOf = \_ -> (24 :: Int)

  staticAlignment = \_ -> (8 :: Int)

instance Marshal.ReadRaw Fcft_grapheme where

  readRaw =
    \ptr0 ->
          pure Fcft_grapheme
      <*> HasCField.readRaw (RIP.Proxy @"fcft_grapheme_cols") ptr0
      <*> HasCField.readRaw (RIP.Proxy @"fcft_grapheme_count") ptr0
      <*> HasCField.readRaw (RIP.Proxy @"fcft_grapheme_glyphs") ptr0

instance Marshal.WriteRaw Fcft_grapheme where

  writeRaw =
    \ptr0 ->
      \s1 ->
        case s1 of
          Fcft_grapheme fcft_grapheme_cols2 fcft_grapheme_count3 fcft_grapheme_glyphs4 ->
               HasCField.writeRaw (RIP.Proxy @"fcft_grapheme_cols") ptr0 fcft_grapheme_cols2
            >> HasCField.writeRaw (RIP.Proxy @"fcft_grapheme_count") ptr0 fcft_grapheme_count3
            >> HasCField.writeRaw (RIP.Proxy @"fcft_grapheme_glyphs") ptr0 fcft_grapheme_glyphs4

deriving via Marshal.EquivStorable Fcft_grapheme instance RIP.Storable Fcft_grapheme

instance HasCField.HasCField Fcft_grapheme "fcft_grapheme_cols" where

  type CFieldType Fcft_grapheme "fcft_grapheme_cols" =
    RIP.CInt

  offset# = \_ -> \_ -> 0

instance ( ((~) ty) RIP.CInt
         ) => RIP.HasField "fcft_grapheme_cols" (RIP.Ptr Fcft_grapheme) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_grapheme_cols")

instance HasCField.HasCField Fcft_grapheme "fcft_grapheme_count" where

  type CFieldType Fcft_grapheme "fcft_grapheme_count" =
    HsBindgen.Runtime.LibC.CSize

  offset# = \_ -> \_ -> 8

instance ( ((~) ty) HsBindgen.Runtime.LibC.CSize
         ) => RIP.HasField "fcft_grapheme_count" (RIP.Ptr Fcft_grapheme) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_grapheme_count")

instance HasCField.HasCField Fcft_grapheme "fcft_grapheme_glyphs" where

  type CFieldType Fcft_grapheme "fcft_grapheme_glyphs" =
    RIP.Ptr (PtrConst.PtrConst Fcft_glyph)

  offset# = \_ -> \_ -> 16

instance ( ((~) ty) (RIP.Ptr (PtrConst.PtrConst Fcft_glyph))
         ) => RIP.HasField "fcft_grapheme_glyphs" (RIP.Ptr Fcft_grapheme) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_grapheme_glyphs")

{-| __C declaration:__ @struct fcft_text_run@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 139:8@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
data Fcft_text_run = Fcft_text_run
  { fcft_text_run_glyphs :: RIP.Ptr (PtrConst.PtrConst Fcft_glyph)
    {- ^ __C declaration:__ @glyphs@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 140:31@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  , fcft_text_run_cluster :: RIP.Ptr RIP.CInt
    {- ^ __C declaration:__ @cluster@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 141:10@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  , fcft_text_run_count :: HsBindgen.Runtime.LibC.CSize
    {- ^ __C declaration:__ @count@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 142:12@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  }
  deriving stock (Eq, RIP.Generic, Show)

instance Marshal.StaticSize Fcft_text_run where

  staticSizeOf = \_ -> (24 :: Int)

  staticAlignment = \_ -> (8 :: Int)

instance Marshal.ReadRaw Fcft_text_run where

  readRaw =
    \ptr0 ->
          pure Fcft_text_run
      <*> HasCField.readRaw (RIP.Proxy @"fcft_text_run_glyphs") ptr0
      <*> HasCField.readRaw (RIP.Proxy @"fcft_text_run_cluster") ptr0
      <*> HasCField.readRaw (RIP.Proxy @"fcft_text_run_count") ptr0

instance Marshal.WriteRaw Fcft_text_run where

  writeRaw =
    \ptr0 ->
      \s1 ->
        case s1 of
          Fcft_text_run
            fcft_text_run_glyphs2
            fcft_text_run_cluster3
            fcft_text_run_count4 ->
                 HasCField.writeRaw (RIP.Proxy @"fcft_text_run_glyphs") ptr0 fcft_text_run_glyphs2
              >> HasCField.writeRaw (RIP.Proxy @"fcft_text_run_cluster") ptr0 fcft_text_run_cluster3
              >> HasCField.writeRaw (RIP.Proxy @"fcft_text_run_count") ptr0 fcft_text_run_count4

deriving via Marshal.EquivStorable Fcft_text_run instance RIP.Storable Fcft_text_run

instance HasCField.HasCField Fcft_text_run "fcft_text_run_glyphs" where

  type CFieldType Fcft_text_run "fcft_text_run_glyphs" =
    RIP.Ptr (PtrConst.PtrConst Fcft_glyph)

  offset# = \_ -> \_ -> 0

instance ( ((~) ty) (RIP.Ptr (PtrConst.PtrConst Fcft_glyph))
         ) => RIP.HasField "fcft_text_run_glyphs" (RIP.Ptr Fcft_text_run) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_text_run_glyphs")

instance HasCField.HasCField Fcft_text_run "fcft_text_run_cluster" where

  type CFieldType Fcft_text_run "fcft_text_run_cluster" =
    RIP.Ptr RIP.CInt

  offset# = \_ -> \_ -> 8

instance ( ((~) ty) (RIP.Ptr RIP.CInt)
         ) => RIP.HasField "fcft_text_run_cluster" (RIP.Ptr Fcft_text_run) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_text_run_cluster")

instance HasCField.HasCField Fcft_text_run "fcft_text_run_count" where

  type CFieldType Fcft_text_run "fcft_text_run_count" =
    HsBindgen.Runtime.LibC.CSize

  offset# = \_ -> \_ -> 16

instance ( ((~) ty) HsBindgen.Runtime.LibC.CSize
         ) => RIP.HasField "fcft_text_run_count" (RIP.Ptr Fcft_text_run) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_text_run_count")

{-| __C declaration:__ @enum fcft_scaling_filter@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 167:6@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
newtype Fcft_scaling_filter = Fcft_scaling_filter
  { unwrapFcft_scaling_filter :: RIP.CUInt
  }
  deriving stock (Eq, RIP.Generic, Ord)
  deriving newtype (RIP.HasFFIType)

instance Marshal.StaticSize Fcft_scaling_filter where

  staticSizeOf = \_ -> (4 :: Int)

  staticAlignment = \_ -> (4 :: Int)

instance Marshal.ReadRaw Fcft_scaling_filter where

  readRaw =
    \ptr0 ->
          pure Fcft_scaling_filter
      <*> Marshal.readRawByteOff ptr0 (0 :: Int)

instance Marshal.WriteRaw Fcft_scaling_filter where

  writeRaw =
    \ptr0 ->
      \s1 ->
        case s1 of
          Fcft_scaling_filter unwrapFcft_scaling_filter2 ->
            Marshal.writeRawByteOff ptr0 (0 :: Int) unwrapFcft_scaling_filter2

deriving via Marshal.EquivStorable Fcft_scaling_filter instance RIP.Storable Fcft_scaling_filter

deriving via RIP.CUInt instance RIP.Prim Fcft_scaling_filter

instance CEnum.CEnum Fcft_scaling_filter where

  type CEnumZ Fcft_scaling_filter = RIP.CUInt

  toCEnum = Fcft_scaling_filter

  fromCEnum = unwrapFcft_scaling_filter

  declaredValues =
    \_ ->
      CEnum.declaredValuesFromList [ (0, RIP.singleton "FCFT_SCALING_FILTER_NONE")
                                   , (1, RIP.singleton "FCFT_SCALING_FILTER_NEAREST")
                                   , (2, RIP.singleton "FCFT_SCALING_FILTER_BILINEAR")
                                   , (3, RIP.singleton "FCFT_SCALING_FILTER_CUBIC")
                                   , (4, RIP.singleton "FCFT_SCALING_FILTER_LANCZOS3")
                                   , (5, RIP.singleton "FCFT_SCALING_FILTER_IMPULSE")
                                   , (6, RIP.singleton "FCFT_SCALING_FILTER_BOX")
                                   , (7, RIP.singleton "FCFT_SCALING_FILTER_LINEAR")
                                   , (8, RIP.singleton "FCFT_SCALING_FILTER_GAUSSIAN")
                                   , (9, RIP.singleton "FCFT_SCALING_FILTER_LANCZOS2")
                                   , (10, RIP.singleton "FCFT_SCALING_FILTER_LANCZOS3_STRETCHED")
                                   ]

  showsUndeclared =
    CEnum.showsWrappedUndeclared "Fcft_scaling_filter"

  readPrecUndeclared =
    CEnum.readPrecWrappedUndeclared "Fcft_scaling_filter"

  isDeclared = CEnum.seqIsDeclared

  mkDeclared = CEnum.seqMkDeclared

instance CEnum.SequentialCEnum Fcft_scaling_filter where

  minDeclaredValue = FCFT_SCALING_FILTER_NONE

  maxDeclaredValue =
    FCFT_SCALING_FILTER_LANCZOS3_STRETCHED

instance Show Fcft_scaling_filter where

  showsPrec = CEnum.shows

instance Read Fcft_scaling_filter where

  readPrec = CEnum.readPrec

  readList = RIP.readListDefault

  readListPrec = RIP.readListPrecDefault

instance ( ((~) ty) RIP.CUInt
         ) => RIP.HasField "unwrapFcft_scaling_filter" (RIP.Ptr Fcft_scaling_filter) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"unwrapFcft_scaling_filter")

instance HasCField.HasCField Fcft_scaling_filter "unwrapFcft_scaling_filter" where

  type CFieldType Fcft_scaling_filter "unwrapFcft_scaling_filter" =
    RIP.CUInt

  offset# = \_ -> \_ -> 0

{-| __C declaration:__ @FCFT_SCALING_FILTER_NONE@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 168:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern FCFT_SCALING_FILTER_NONE :: Fcft_scaling_filter
pattern FCFT_SCALING_FILTER_NONE = Fcft_scaling_filter 0

{-| __C declaration:__ @FCFT_SCALING_FILTER_NEAREST@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 169:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern FCFT_SCALING_FILTER_NEAREST :: Fcft_scaling_filter
pattern FCFT_SCALING_FILTER_NEAREST = Fcft_scaling_filter 1

{-| __C declaration:__ @FCFT_SCALING_FILTER_BILINEAR@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 170:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern FCFT_SCALING_FILTER_BILINEAR :: Fcft_scaling_filter
pattern FCFT_SCALING_FILTER_BILINEAR = Fcft_scaling_filter 2

{-| __C declaration:__ @FCFT_SCALING_FILTER_CUBIC@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 176:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern FCFT_SCALING_FILTER_CUBIC :: Fcft_scaling_filter
pattern FCFT_SCALING_FILTER_CUBIC = Fcft_scaling_filter 3

{-| __C declaration:__ @FCFT_SCALING_FILTER_LANCZOS3@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 177:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern FCFT_SCALING_FILTER_LANCZOS3 :: Fcft_scaling_filter
pattern FCFT_SCALING_FILTER_LANCZOS3 = Fcft_scaling_filter 4

{-| __C declaration:__ @FCFT_SCALING_FILTER_IMPULSE@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 180:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern FCFT_SCALING_FILTER_IMPULSE :: Fcft_scaling_filter
pattern FCFT_SCALING_FILTER_IMPULSE = Fcft_scaling_filter 5

{-| __C declaration:__ @FCFT_SCALING_FILTER_BOX@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 181:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern FCFT_SCALING_FILTER_BOX :: Fcft_scaling_filter
pattern FCFT_SCALING_FILTER_BOX = Fcft_scaling_filter 6

{-| __C declaration:__ @FCFT_SCALING_FILTER_LINEAR@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 182:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern FCFT_SCALING_FILTER_LINEAR :: Fcft_scaling_filter
pattern FCFT_SCALING_FILTER_LINEAR = Fcft_scaling_filter 7

{-| __C declaration:__ @FCFT_SCALING_FILTER_GAUSSIAN@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 183:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern FCFT_SCALING_FILTER_GAUSSIAN :: Fcft_scaling_filter
pattern FCFT_SCALING_FILTER_GAUSSIAN = Fcft_scaling_filter 8

{-| __C declaration:__ @FCFT_SCALING_FILTER_LANCZOS2@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 184:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern FCFT_SCALING_FILTER_LANCZOS2 :: Fcft_scaling_filter
pattern FCFT_SCALING_FILTER_LANCZOS2 = Fcft_scaling_filter 9

{-| __C declaration:__ @FCFT_SCALING_FILTER_LANCZOS3_STRETCHED@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 185:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern FCFT_SCALING_FILTER_LANCZOS3_STRETCHED :: Fcft_scaling_filter
pattern FCFT_SCALING_FILTER_LANCZOS3_STRETCHED = Fcft_scaling_filter 10

{-| __C declaration:__ @enum fcft_emoji_presentation@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 210:6@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
newtype Fcft_emoji_presentation = Fcft_emoji_presentation
  { unwrapFcft_emoji_presentation :: RIP.CUInt
  }
  deriving stock (Eq, RIP.Generic, Ord)
  deriving newtype (RIP.HasFFIType)

instance Marshal.StaticSize Fcft_emoji_presentation where

  staticSizeOf = \_ -> (4 :: Int)

  staticAlignment = \_ -> (4 :: Int)

instance Marshal.ReadRaw Fcft_emoji_presentation where

  readRaw =
    \ptr0 ->
          pure Fcft_emoji_presentation
      <*> Marshal.readRawByteOff ptr0 (0 :: Int)

instance Marshal.WriteRaw Fcft_emoji_presentation where

  writeRaw =
    \ptr0 ->
      \s1 ->
        case s1 of
          Fcft_emoji_presentation unwrapFcft_emoji_presentation2 ->
            Marshal.writeRawByteOff ptr0 (0 :: Int) unwrapFcft_emoji_presentation2

deriving via Marshal.EquivStorable Fcft_emoji_presentation instance RIP.Storable Fcft_emoji_presentation

deriving via RIP.CUInt instance RIP.Prim Fcft_emoji_presentation

instance CEnum.CEnum Fcft_emoji_presentation where

  type CEnumZ Fcft_emoji_presentation = RIP.CUInt

  toCEnum = Fcft_emoji_presentation

  fromCEnum = unwrapFcft_emoji_presentation

  declaredValues =
    \_ ->
      CEnum.declaredValuesFromList [ (0, RIP.singleton "FCFT_EMOJI_PRESENTATION_DEFAULT")
                                   , (1, RIP.singleton "FCFT_EMOJI_PRESENTATION_TEXT")
                                   , (2, RIP.singleton "FCFT_EMOJI_PRESENTATION_EMOJI")
                                   ]

  showsUndeclared =
    CEnum.showsWrappedUndeclared "Fcft_emoji_presentation"

  readPrecUndeclared =
    CEnum.readPrecWrappedUndeclared "Fcft_emoji_presentation"

  isDeclared = CEnum.seqIsDeclared

  mkDeclared = CEnum.seqMkDeclared

instance CEnum.SequentialCEnum Fcft_emoji_presentation where

  minDeclaredValue = FCFT_EMOJI_PRESENTATION_DEFAULT

  maxDeclaredValue = FCFT_EMOJI_PRESENTATION_EMOJI

instance Show Fcft_emoji_presentation where

  showsPrec = CEnum.shows

instance Read Fcft_emoji_presentation where

  readPrec = CEnum.readPrec

  readList = RIP.readListDefault

  readListPrec = RIP.readListPrecDefault

instance ( ((~) ty) RIP.CUInt
         ) => RIP.HasField "unwrapFcft_emoji_presentation" (RIP.Ptr Fcft_emoji_presentation) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"unwrapFcft_emoji_presentation")

instance HasCField.HasCField Fcft_emoji_presentation "unwrapFcft_emoji_presentation" where

  type CFieldType Fcft_emoji_presentation "unwrapFcft_emoji_presentation" =
    RIP.CUInt

  offset# = \_ -> \_ -> 0

{-| __C declaration:__ @FCFT_EMOJI_PRESENTATION_DEFAULT@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 211:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern FCFT_EMOJI_PRESENTATION_DEFAULT :: Fcft_emoji_presentation
pattern FCFT_EMOJI_PRESENTATION_DEFAULT = Fcft_emoji_presentation 0

{-| __C declaration:__ @FCFT_EMOJI_PRESENTATION_TEXT@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 212:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern FCFT_EMOJI_PRESENTATION_TEXT :: Fcft_emoji_presentation
pattern FCFT_EMOJI_PRESENTATION_TEXT = Fcft_emoji_presentation 1

{-| __C declaration:__ @FCFT_EMOJI_PRESENTATION_EMOJI@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 213:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
pattern FCFT_EMOJI_PRESENTATION_EMOJI :: Fcft_emoji_presentation
pattern FCFT_EMOJI_PRESENTATION_EMOJI = Fcft_emoji_presentation 2

{-| __C declaration:__ @struct \@fcft_font_options_color_glyphs@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 226:5@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
data Fcft_font_options_color_glyphs = Fcft_font_options_color_glyphs
  { fcft_font_options_color_glyphs_srgb_decode :: HsBindgen.Runtime.LibC.CBool
    {- ^ __C declaration:__ @srgb_decode@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 227:14@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  , fcft_font_options_color_glyphs_format :: Pixman_format_code_t
    {- ^ __C declaration:__ @format@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 228:30@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  }
  deriving stock (Eq, RIP.Generic, Show)

instance Marshal.StaticSize Fcft_font_options_color_glyphs where

  staticSizeOf = \_ -> (8 :: Int)

  staticAlignment = \_ -> (4 :: Int)

instance Marshal.ReadRaw Fcft_font_options_color_glyphs where

  readRaw =
    \ptr0 ->
          pure Fcft_font_options_color_glyphs
      <*> HasCField.readRaw (RIP.Proxy @"fcft_font_options_color_glyphs_srgb_decode") ptr0
      <*> HasCField.readRaw (RIP.Proxy @"fcft_font_options_color_glyphs_format") ptr0

instance Marshal.WriteRaw Fcft_font_options_color_glyphs where

  writeRaw =
    \ptr0 ->
      \s1 ->
        case s1 of
          Fcft_font_options_color_glyphs
            fcft_font_options_color_glyphs_srgb_decode2
            fcft_font_options_color_glyphs_format3 ->
                 HasCField.writeRaw (RIP.Proxy @"fcft_font_options_color_glyphs_srgb_decode") ptr0 fcft_font_options_color_glyphs_srgb_decode2
              >> HasCField.writeRaw (RIP.Proxy @"fcft_font_options_color_glyphs_format") ptr0 fcft_font_options_color_glyphs_format3

deriving via Marshal.EquivStorable Fcft_font_options_color_glyphs instance RIP.Storable Fcft_font_options_color_glyphs

instance HasCField.HasCField Fcft_font_options_color_glyphs "fcft_font_options_color_glyphs_srgb_decode" where

  type CFieldType Fcft_font_options_color_glyphs "fcft_font_options_color_glyphs_srgb_decode" =
    HsBindgen.Runtime.LibC.CBool

  offset# = \_ -> \_ -> 0

instance ( ((~) ty) HsBindgen.Runtime.LibC.CBool
         ) => RIP.HasField "fcft_font_options_color_glyphs_srgb_decode" (RIP.Ptr Fcft_font_options_color_glyphs) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_font_options_color_glyphs_srgb_decode")

instance HasCField.HasCField Fcft_font_options_color_glyphs "fcft_font_options_color_glyphs_format" where

  type CFieldType Fcft_font_options_color_glyphs "fcft_font_options_color_glyphs_format" =
    Pixman_format_code_t

  offset# = \_ -> \_ -> 4

instance ( ((~) ty) Pixman_format_code_t
         ) => RIP.HasField "fcft_font_options_color_glyphs_format" (RIP.Ptr Fcft_font_options_color_glyphs) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_font_options_color_glyphs_format")

{-| __C declaration:__ @struct fcft_font_options@

    __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 223:8@

    __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
-}
data Fcft_font_options = Fcft_font_options
  { fcft_font_options_emoji_presentation :: Fcft_emoji_presentation
    {- ^ __C declaration:__ @emoji_presentation@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 224:34@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  , fcft_font_options_color_glyphs :: Fcft_font_options_color_glyphs
    {- ^ __C declaration:__ @color_glyphs@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 229:7@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  , fcft_font_options_scaling_filter :: Fcft_scaling_filter
    {- ^ __C declaration:__ @scaling_filter@

         __defined at:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h 231:30@

         __exported by:__ @\/nix\/store\/gvh74ry77q456n8i1sdd8d3s9zqv8wm7-fcft-3.3.3\/include\/fcft\/fcft.h@
    -}
  }
  deriving stock (Eq, RIP.Generic, Show)

instance Marshal.StaticSize Fcft_font_options where

  staticSizeOf = \_ -> (16 :: Int)

  staticAlignment = \_ -> (4 :: Int)

instance Marshal.ReadRaw Fcft_font_options where

  readRaw =
    \ptr0 ->
          pure Fcft_font_options
      <*> HasCField.readRaw (RIP.Proxy @"fcft_font_options_emoji_presentation") ptr0
      <*> HasCField.readRaw (RIP.Proxy @"fcft_font_options_color_glyphs") ptr0
      <*> HasCField.readRaw (RIP.Proxy @"fcft_font_options_scaling_filter") ptr0

instance Marshal.WriteRaw Fcft_font_options where

  writeRaw =
    \ptr0 ->
      \s1 ->
        case s1 of
          Fcft_font_options
            fcft_font_options_emoji_presentation2
            fcft_font_options_color_glyphs3
            fcft_font_options_scaling_filter4 ->
                 HasCField.writeRaw (RIP.Proxy @"fcft_font_options_emoji_presentation") ptr0 fcft_font_options_emoji_presentation2
              >> HasCField.writeRaw (RIP.Proxy @"fcft_font_options_color_glyphs") ptr0 fcft_font_options_color_glyphs3
              >> HasCField.writeRaw (RIP.Proxy @"fcft_font_options_scaling_filter") ptr0 fcft_font_options_scaling_filter4

deriving via Marshal.EquivStorable Fcft_font_options instance RIP.Storable Fcft_font_options

instance HasCField.HasCField Fcft_font_options "fcft_font_options_emoji_presentation" where

  type CFieldType Fcft_font_options "fcft_font_options_emoji_presentation" =
    Fcft_emoji_presentation

  offset# = \_ -> \_ -> 0

instance ( ((~) ty) Fcft_emoji_presentation
         ) => RIP.HasField "fcft_font_options_emoji_presentation" (RIP.Ptr Fcft_font_options) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_font_options_emoji_presentation")

instance HasCField.HasCField Fcft_font_options "fcft_font_options_color_glyphs" where

  type CFieldType Fcft_font_options "fcft_font_options_color_glyphs" =
    Fcft_font_options_color_glyphs

  offset# = \_ -> \_ -> 4

instance ( ((~) ty) Fcft_font_options_color_glyphs
         ) => RIP.HasField "fcft_font_options_color_glyphs" (RIP.Ptr Fcft_font_options) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_font_options_color_glyphs")

instance HasCField.HasCField Fcft_font_options "fcft_font_options_scaling_filter" where

  type CFieldType Fcft_font_options "fcft_font_options_scaling_filter" =
    Fcft_scaling_filter

  offset# = \_ -> \_ -> 12

instance ( ((~) ty) Fcft_scaling_filter
         ) => RIP.HasField "fcft_font_options_scaling_filter" (RIP.Ptr Fcft_font_options) (RIP.Ptr ty) where

  getField =
    HasCField.fromPtr (RIP.Proxy @"fcft_font_options_scaling_filter")
