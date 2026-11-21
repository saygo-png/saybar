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
    developPackageArgs.overrides = hself: hsuper: {
      sayland = lib.pipe (hself.callPackage "${saylandSrc}/cabal.nix" {}) [
        (hlib.overrideCabal {
          src = saylandSrc;
          buildTarget = "lib:sayland lib:sayland-wire";
        })
        hlib.dontCheck
        hlib.disableLibraryProfiling
      ];
      hs-bindgen-runtime = lib.pipe hsuper.hs-bindgen-runtime [
        hlib.dontCheck
        hlib.dontHaddock
        hlib.disableLibraryProfiling
      ];
    };
  }
