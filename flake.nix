{
  inputs = {
    treefmt-nix.url = "github:numtide/treefmt-nix";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    niceHaskell = {
      url = "github:saygo-png/nice-nixpkgs-haskell";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        treefmt-nix.follows = "treefmt-nix";
      };
    };
    saylandSrc = {
      url = "github:saygo-png/sayland";
      flake = false;
    };
    systems = {
      url = "path:./systems.nix";
      flake = false;
    };
    hs-bindgen.url = "github:well-typed/hs-bindgen";
  };

  outputs = {
    nixpkgs,
    systems,
    saylandSrc,
    hs-bindgen,
    treefmt-nix,
    self,
    ...
  } @ inputs: let
    pkgsFor = nixpkgs.lib.genAttrs (import systems) (system:
      import nixpkgs {
        inherit system;
        overlays = [hs-bindgen.overlays.default];
      });
    eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f system pkgsFor.${system});
  in {
    packages = eachSystem (system: pkgs: let
      niceHaskell = inputs.niceHaskell.outputs.niceHaskell.${system};
    in rec {
      sayland = niceHaskell.mkPackage {
        packageRoot = saylandSrc;
        cabalName = "sayland";
        flags = niceHaskell.mkFlags {
          doCheck = false;
          doHaddock = false;
        };
      };

      saybar = pkgs.callPackage ./package.nix {
        # Provide dependencies for nix based builds
        inherit (pkgs.haskellPackages) c-expr-runtime hs-bindgen-runtime;
        inherit sayland;
        inherit niceHaskell;
      };

      default = saybar;
    });

    formatter = eachSystem (_system: pkgs: (treefmt-nix.lib.evalModule pkgs ./treefmt.nix).config.build.wrapper);

    devShells = eachSystem (
      system: pkgs: let
        niceHaskell = inputs.niceHaskell.outputs.niceHaskell.${system};
        haskellShell =
          (pkgs.callPackage ./package.nix {
            inherit niceHaskell;
            inherit (pkgs.haskellPackages) c-expr-runtime hs-bindgen-runtime;
            inherit (self.packages.${system}) sayland;
            shell = true;
          }).overrideAttrs (old: {
            nativeBuildInputs =
              old.nativeBuildInputs
              ++ [
                self.formatter.${system}
                pkgs.haskellPackages.cabal-install
                pkgs.haskellPackages.haskell-language-server
                # hs-bindgen cli
                pkgs.hs-bindgen-cli
                # Connect hs-bindgen to the Clang toolchain and `libpcap`
                pkgs.hsBindgenHook
              ];
            buildInputs =
              old.buildInputs
              ++ [
                pkgs.zlib

                # fcft deps
                pkgs.pkg-config
                pkgs.freetype
                pkgs.fontconfig
                pkgs.nanosvg
                pkgs.pixman
                pkgs.tllist
                pkgs.expat
                pkgs.harfbuzz
                pkgs.glib
                pkgs.libsysprof-capture
                pkgs.pcre2
                pkgs.libutf8proc
                pkgs.fcft
              ];
            shellHook = ''
              export LD_LIBRARY_PATH="$PWD/fcft/lib:$LD_LIBRARY_PATH"
            '';
          });
      in {
        inherit haskellShell;
        default = haskellShell;
      }
    );
  };
}
