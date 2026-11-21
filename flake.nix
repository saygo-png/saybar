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
    pkgsFor = nixpkgs.lib.genAttrs (import systems) (system: import nixpkgs {inherit system;});
    eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f system pkgsFor.${system});
  in {
    packages = eachSystem (system: pkgs: let
      saybar = pkgs.callPackage ./package.nix {
        niceHaskell = niceHaskell.outputs.niceHaskell.${system};
        inherit saylandSrc hs-bindgen;
      };
    in {
      inherit saybar;
      default = saybar;
    });

    formatter = eachSystem (_system: pkgs: (treefmt-nix.lib.evalModule pkgs ./treefmt.nix).config.build.wrapper);

    devShells = eachSystem (system: pkgs: let
      inherit (hs-bindgen.packages.${system}) hs-bindgen-cli hsBindgenHook;

      generate-cabal2nix = pkgs.writeShellApplication {
        name = "generate-cabal2nix";
        runtimeInputs = [pkgs.cabal2nix];
        text = "cabal2nix . > cabal.nix";
      };

      generate-bindings = pkgs.writeShellApplication {
        name = "generate-bindings";
        runtimeInputs = [pkgs.pkg-config hs-bindgen-cli];
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
          generate-cabal2nix
        ];
        shellHook = ''
          echo ""
          echo "-------------"
          echo "\"generate-cabal2nix\""
          echo "regenerate cabal.nix after changing saybar.cabal"
          echo ""
          echo "\"nix develop .#bindings -c generate-bindings\""
          echo "regenerate bindings, after updating nixpkgs or hs-bindgen"
          echo "-------------"
          echo ""
        '';
      };

      bindings = pkgs.mkShell {
        inputsFrom = [self.packages.${system}.saybar.env];
        packages = [
          hsBindgenHook
          generate-bindings
        ];
        shellHook = ''
          echo ""
          echo "-------------"
          echo "generate-bindings regenerate bindings/ for the locked nixpkgs and hs-bindgen"
          echo "-------------"
          echo ""
        '';
      };
    });
  };
}
