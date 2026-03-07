{-# LANGUAGE TemplateHaskellQuotes #-}

{- |
Module      : SaywaylandTH
Description : Template Haskell macros to eliminate Wayland event boilerplate.

To add a new event, add one entry to the 'declareEvents' splice:

@
event "ExtWorkspaceHandleV1" 5 "removed" []
event "WlDisplay" 0 "error"
  [ ("errorObjectID", ty ''Word32)
  , ("errorCode",     ty ''WlUint)
  , ("errorMessage",  ty ''WlString)
  ]
@

Each entry generates:
  * A @Body\<Interface\>_\<name\>@ data type (with Generic\/Show\/Binary via LittleEndian)
  * An @Ev\<Interface\>_\<name\> Header Body…@ constructor in 'WaylandEvent'
  * A @(Just \<Interface\>, opCode)@ case in @parseEvent@
-}
module SaywaylandTH (
  EventSpec,
  event,
  ty,
  appTy,
  declareEvents,
) where

import Language.Haskell.TH
import Relude hiding (Type)

-- ---------------------------------------------------------------------------
-- Public API
-- ---------------------------------------------------------------------------

-- | Specification for a single Wayland event.
data EventSpec = EventSpec
  { interface :: String
  -- ^ PascalCase interface name, e.g. @"WlDisplay"@
  , opCode :: Int
  -- ^ Wire opcode (0-based, per interface)
  , name :: String
  -- ^ camelCase event name,  e.g. @"error"@, @"deleteID"@
  , fields :: [(String, Q Type)]
  -- ^ @[(fieldName, fieldType)]@
  }

{- | Declare an event spec. Intended to be used inside 'declareEvents'.

@
event "WlDisplay" 0 "error"
  [ ("errorObjectID", ty ''Word32)
  , ("errorCode",     ty ''WlUint)
  , ("errorMessage",  ty ''WlString)
  ]
@
-}
event :: String -> Int -> String -> [(String, Q Type)] -> EventSpec
event = EventSpec

-- | Lift a plain 'Name' into a field type.  Use @ty ''Foo@ for @Foo@.
ty :: Name -> Q Type
ty = pure . ConT

-- | Lift two 'Name's into an applied type.  Use @appTy ''Foo ''Bar@ for @Foo Bar@.
appTy :: Name -> Name -> Q Type
appTy f x = pure $ AppT (ConT f) (ConT x)

{- | Top-level splice.  Pass a list of 'event' specs; this generates:

  1. @Body\<Interface\>_\<name\>@ data declarations
  2. The @WaylandEvent@ sum type
  3. The @parseEvent@ function
-}
declareEvents :: [EventSpec] -> Q [Dec]
declareEvents specs = do
  bodyDecls <- concat <$> mapM mkBodyDecl specs
  eventDecl <- mkEventDecl specs
  parseDecs <- mkParseDecl specs
  pure $ bodyDecls ++ [eventDecl] ++ parseDecs

-- ---------------------------------------------------------------------------
-- Internal helpers
-- ---------------------------------------------------------------------------

-- | @Body\<Interface\>_\<name\>@
bodyTypeName :: EventSpec -> Name
bodyTypeName es = mkName $ "Body" ++ es.interface ++ "_" ++ es.name

-- | @Ev\<Interface\>_\<name\>@
evConName :: EventSpec -> Name
evConName es = mkName $ "Ev" ++ es.interface ++ "_" ++ es.name

-- ---------------------------------------------------------------------------
-- 1. Body data-type generation
-- ---------------------------------------------------------------------------

{- | Generate a single @Body*@ data declaration.

Zero fields  → @data Body… = Body…@
One or more  → @data Body… = Body… { field :: Type, … }@

Both variants derive @Generic@, @Show@, and @Binary@ via @LittleEndian@.
-}
mkBodyDecl :: EventSpec -> Q [Dec]
mkBodyDecl es = do
  let tyName = bodyTypeName es
      bang' = Bang NoSourceUnpackedness NoSourceStrictness

  -- Resolve the Q Type values for each field
  resolvedFields <- mapM (\(fn, qt) -> (fn,) <$> qt) es.fields

  let con = case resolvedFields of
        -- Empty constructor (no-payload events like "done", "removed")
        [] -> NormalC tyName []
        -- Record constructor (one or more fields)
        fs ->
          RecC
            tyName
            [(mkName fn, bang', t) | (fn, t) <- fs]

      -- deriving stock (Generic, Show)
      stockDeriv = DerivClause (Just StockStrategy) [ConT ''Generic, ConT ''Show]

      -- deriving (Binary) via (LittleEndian Body…)
      viaDeriv =
        DerivClause
          (Just (ViaStrategy (AppT (ConT (mkName "LittleEndian")) (ConT tyName))))
          [ConT (mkName "Binary")]

      dataDec = DataD [] tyName [] Nothing [con] [stockDeriv, viaDeriv]

  pure [dataDec]

-- ---------------------------------------------------------------------------
-- 2. WaylandEvent sum-type generation
-- ---------------------------------------------------------------------------

{- | Build the complete @WaylandEvent@ data type.

Each spec contributes one @Ev\<Interface\>_\<name\> Header Body…@ constructor.
A catch-all @EvUnknown Header@ constructor is appended automatically.
-}
mkEventDecl :: [EventSpec] -> Q Dec
mkEventDecl specs = do
  let bang' = Bang NoSourceUnpackedness NoSourceStrictness
      headerT = ConT (mkName "Header")

      mkCon es =
        NormalC
          (evConName es)
          [ (bang', headerT)
          , (bang', ConT (bodyTypeName es))
          ]

      unknownCon = NormalC (mkName "EvUnknown") [(bang', headerT)]

  pure
    $ DataD
      []
      (mkName "WaylandEvent")
      []
      Nothing
      (map mkCon specs ++ [unknownCon])
      []

-- ---------------------------------------------------------------------------
-- 3. parseEvent function generation
-- ---------------------------------------------------------------------------

{- | Build the @parseEvent@ function.

Generates:

@
parseEvent objects = do
  header <- get
  let bodySize = fromIntegral header.size - 8
  case (Map.lookup header.objectID objects, header.opCode) of
    (Just WlDisplay,  0) -> EvWlDisplay_error header \<$\> get
    …
    _                    -> skip bodySize $> EvUnknown header
@
-}
mkParseDecl :: [EventSpec] -> Q [Dec]
mkParseDecl specs = do
  let headerV = mkName "header"
      objectsV = mkName "objects"
      bodySzV = mkName "bodySize"

      -- One case arm per event spec
      mkArm es =
        Match
          -- Pattern: (Just <Interface>, <opCode>)
          ( TupP
              [ ConP (mkName "Just") [] [ConP (mkName es.interface) [] []]
              , LitP (IntegerL (fromIntegral es.opCode))
              ]
          )
          -- Body: Ev<Interface>_<name> header <$> get
          ( NormalB
              $ InfixE
                (Just (AppE (ConE (evConName es)) (VarE headerV)))
                (VarE (mkName "<$>"))
                (Just (VarE (mkName "get")))
          )
          []

      -- Wildcard arm: _ -> skip bodySize $> EvUnknown header
      wildcardArm =
        Match
          WildP
          ( NormalB
              $ InfixE
                (Just (AppE (VarE (mkName "skip")) (VarE bodySzV)))
                (VarE (mkName "$>"))
                (Just (AppE (ConE (mkName "EvUnknown")) (VarE headerV)))
          )
          []

      -- header.field  (GetFieldE respects NoFieldSelectors)
      hField = GetFieldE (VarE headerV)

      -- case (Map.lookup header.objectID objects, header.opCode) of …
      caseExpr =
        CaseE
          ( TupE
              [ Just
                  $ AppE
                    (AppE (VarE (mkName "Map.lookup")) (hField "objectID"))
                    (VarE objectsV)
              , Just (hField "opCode")
              ]
          )
          (map mkArm specs ++ [wildcardArm])

      -- fromIntegral header.size - 8
      bodySzExpr =
        InfixE
          (Just (AppE (VarE (mkName "fromIntegral")) (hField "size")))
          (VarE (mkName "-"))
          (Just (LitE (IntegerL 8)))

      doStmts =
        [ BindS (VarP headerV) (VarE (mkName "get"))
        , LetS [ValD (VarP bodySzV) (NormalB bodySzExpr) []]
        , NoBindS caseExpr
        ]

  let sig =
        SigD
          (mkName "parseEvent")
          ( ArrowT
              `AppT` (ConT (mkName "Map") `AppT` ConT ''Word32 `AppT` ConT (mkName "WaylandInterface"))
              `AppT` (ConT (mkName "Get") `AppT` ConT (mkName "WaylandEvent"))
          )

  pure
    [ sig
    , FunD
        (mkName "parseEvent")
        [ Clause
            [VarP objectsV]
            (NormalB (DoE Nothing doStmts))
            []
        ]
    ]
