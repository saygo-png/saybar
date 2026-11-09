{
  niceHaskell,
  c-expr-runtime,
  hs-bindgen-runtime,
  shell ? false,
  sayland,
  ...
}:
niceHaskell.mkPackage {
  flags = niceHaskell.mkFlags {
    doCheck = false;
    returnShellEnv = shell;
  };
  packageRoot = ./.;
  cabalName = "saybar";
  developPackageArgs.overrides = _: _: {
    inherit c-expr-runtime hs-bindgen-runtime sayland;
  };
}
