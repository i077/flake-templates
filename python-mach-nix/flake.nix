{
  description = "A Python project managed with mach-nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    mach-nix = {
      url = "github:DavHau/mach-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, mach-nix }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShell = let
          pyEnv = mach-nix.lib.${system}.mkPython {
            requirements = builtins.readFile ./requirements.txt;
          };
        in pkgs.mkShell { buildInputs = with pkgs; [ pyEnv ]; };
      });
}
