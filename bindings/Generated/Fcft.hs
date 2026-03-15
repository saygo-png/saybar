{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE DerivingVia #-}
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
    ( Generated.Fcft.Fcft_log_colorize(..)
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
    )
  where

import qualified HsBindgen.Runtime.CEnum as CEnum
import qualified HsBindgen.Runtime.HasCField as HasCField
import qualified HsBindgen.Runtime.Internal.Prelude as RIP
import qualified HsBindgen.Runtime.LibC
import qualified HsBindgen.Runtime.Marshal as Marshal
import qualified HsBindgen.Runtime.PtrConst as PtrConst

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
