{
  niceHaskell,
  saylandSrc,
  hs-bindgen,
}:
niceHaskell.mkPackageNoIFD {
  src = ./.;
  cabal2nix = ./cabal.nix;
  developPackageArgs.overrides = _: _: {
    sayland = niceHaskell.mkPackageNoIFD {
      src = saylandSrc;
      cabal2nix = "${saylandSrc}/cabal.nix";
    };
    hs-bindgen-runtime = niceHaskell.mkPackageNoIFD {
      src = "${hs-bindgen}/hs-bindgen-runtime";
      cabal2nix = "${hs-bindgen}/nix/generated/hs-bindgen-runtime.nix";
    };
  };
}
