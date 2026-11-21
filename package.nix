{
  niceHaskell,
  haskell,
  haskellPackages,
  lib,
  saylandSrc,
}: let
  hlib = haskell.lib.compose;
in
  niceHaskell.mkPackageNoIFD {
    src = ./.;
    cabal2nix = ./cabal.nix;
    inherit haskellPackages;
    developPackageArgs.overrides = hself: _: {
      sayland = lib.pipe (hself.callPackage "${saylandSrc}/cabal.nix" {}) [
        (hlib.overrideCabal {src = saylandSrc;})
        hlib.dontCheck
      ];
    };
  }
