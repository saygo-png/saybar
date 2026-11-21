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
    hs-bindgen = {
      url = "github:well-typed/hs-bindgen";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    systems = {
      url = "path:./systems.nix";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    systems,
    niceHaskell,
    saylandSrc,
    hs-bindgen,
    treefmt-nix,
    self,
    ...
  }: let
    pkgsFor = nixpkgs.lib.genAttrs (import systems) (system:
      import nixpkgs {
        inherit system;
        overlays = [hs-bindgen.overlays.default];
      });
    eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f system pkgsFor.${system});
  in {
    packages = eachSystem (system: pkgs: let
      saybar = pkgs.callPackage ./package.nix {
        niceHaskell = niceHaskell.outputs.niceHaskell.${system};
        inherit saylandSrc;
      };
    in {
      inherit saybar;
      default = saybar;
    });

    formatter = eachSystem (_system: pkgs: (treefmt-nix.lib.evalModule pkgs ./treefmt.nix).config.build.wrapper);

    devShells = eachSystem (system: pkgs: let
      generate-cabal2nix = pkgs.writeShellApplication {
        name = "generate-cabal2nix";
        runtimeInputs = [pkgs.cabal2nix];
        text = "cabal2nix . > cabal.nix";
      };

      generate-bindings = pkgs.writeShellApplication {
        name = "generate-bindings";
        runtimeInputs = [pkgs.pkg-config pkgs.hs-bindgen-cli];
        runtimeEnv.LANG = "C.UTF-8";
        excludeShellChecks = ["SC2207"];
        text = builtins.readFile ./generate-bindings.bash;
      };
    in {
      default = pkgs.mkShell {
        inputsFrom = [self.packages.${system}.saybar.env];
        packages = [
          self.formatter.${system}
          pkgs.cabal-install
          pkgs.haskell-language-server
          pkgs.hs-bindgen-cli
          pkgs.hsBindgenHook
          generate-cabal2nix
          generate-bindings
        ];
        shellHook = ''
          echo "generate-cabal2nix regenerate cabal.nix after changing saybar.cabal"
          echo "generate-bindings regenerate bindings/ after updating nixpkgs or hs-bindgen"
        '';
      };
    });
  };
}
