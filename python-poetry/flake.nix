{
  description = "A Python project managed with Poetry";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.poetry2nix = {
    # url = "github:nix-community/poetry2nix";
    url = "github:K900/poetry2nix/fix-platform";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils, poetry2nix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ poetry2nix.overlay ];
        };
      in {
        devShell = let pyEnv = pkgs.poetry2nix.mkPoetryEnv { projectDir = ./.; };
        in pkgs.mkShell {
          buildInputs = with pkgs; [
            pyEnv
            poetry
          ];
          shellHook = ''
            ln -sfT ${pyEnv.outPath} .venv
          '';
        };
      });
}
