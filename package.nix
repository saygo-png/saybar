{
  niceHaskell,
  c-expr-runtime,
  hs-bindgen-runtime,
  saywayland,
  ...
}:
niceHaskell.mkPackage {
  flags = niceHaskell.mkFlags {doCheck = false;};
  packageRoot = ./.;
  cabalName = "saybar";
  compiler = "ghc912";
  developPackageArgs.overrides = _: _: {
    inherit c-expr-runtime hs-bindgen-runtime saywayland;
  };
}
