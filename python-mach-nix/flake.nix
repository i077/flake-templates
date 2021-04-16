{
  description = "A Python project managed with mach-nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    mach-nix = {
      url = "github:DavHau/mach-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    devshell.url = "github:numtide/devshell";
  };

  outputs = { self, nixpkgs, flake-utils, mach-nix, flake-compat, devshell }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ devshell.overlay ];
        };
      in {
        devShell = let
          pyEnv = mach-nix.lib.${system}.mkPython {
            requirements = builtins.readFile ./requirements.txt;
          };
        in pkgs.devshell.mkShell { packages = with pkgs; [ pyEnv ]; };
      });
}
