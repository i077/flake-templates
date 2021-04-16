{
  description = "A Python project managed with Poetry";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    poetry2nix = {
      url = "github:nix-community/poetry2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    devshell.url = "github:numtide/devshell";
  };

  outputs = { self, nixpkgs, flake-utils, poetry2nix, flake-compat, devshell }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ poetry2nix.overlay devshell.overlay ];
        };
      in {
        devShell =
          let pyEnv = pkgs.poetry2nix.mkPoetryEnv { projectDir = ./.; };
          in pkgs.devshell.mkShell { packages = with pkgs; [ pyEnv poetry ]; };
      });
}
