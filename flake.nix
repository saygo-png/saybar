{
  inputs = {
    treefmt-nix.url = "github:numtide/treefmt-nix";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    niceHaskell = {
      url = "github:saygo-png/nice-nixpkgs-haskell";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        treefmt-nix.follows = "treefmt-nix";
      };
    };
    saywayland = {
      url = "github:saygo-png/saywayland";
      inputs = {
        treefmt-nix.follows = "treefmt-nix";
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        niceHaskell.follows = "niceHaskell";
      };
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
    saywayland,
    niceHaskell,
    hs-bindgen,
    treefmt-nix,
    ...
  }: let
    pkgsFor = nixpkgs.lib.genAttrs (import systems) (system:
      import nixpkgs {
        inherit system;
        overlays = [hs-bindgen.overlays.default];
      });
    eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f system pkgsFor.${system});

    program = system: pkgs:
      pkgs.callPackage ./package.nix {
        niceHaskell = niceHaskell.outputs.niceHaskell.${system};
        # Provide dependencies for nix based builds
        inherit (pkgs.haskell.packages.ghc912) c-expr-runtime hs-bindgen-runtime;
        inherit (saywayland.packages.${system}) saywayland;
      };
  in {
    packages = eachSystem (system: pkgs: {
      "saybar" = program system pkgs;
      default = program system pkgs;
    });

    formatter = eachSystem (_system: pkgs: (treefmt-nix.lib.evalModule pkgs ./treefmt.nix).config.build.wrapper);

    devShells = eachSystem (system: pkgs: {
      default = pkgs.mkShell {
        packages = let
          ghcPackages = pkgs.haskell.packages.ghc912;
          # Provide dependencies for cabal based builds
          ghcWithDeps = ghcPackages.ghcWithPackages (_ps: [
            saywayland.packages.${system}.saywayland
            ghcPackages.c-expr-runtime
            ghcPackages.hs-bindgen-runtime
          ]);
        in [
          pkgs.zlib
          ghcPackages.cabal-install
          ghcWithDeps
          ghcPackages.haskell-language-server

          # hs-bindgen cli
          pkgs.hs-bindgen-cli
          # Connect hs-bindgen to the Clang toolchain and `libpcap`
          pkgs.hsBindgenHook

          # Dependencies for fcft
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
      };
    });
  };
}
