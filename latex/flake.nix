{
  description = "A LaTeX project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    devshell.url = "github:numtide/devshell";
  };

  outputs = { self, nixpkgs, flake-utils, flake-compat, devshell }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ devshell.overlay ];
        };
      in {
        devShell = pkgs.devshell.mkShell {
          packages = with pkgs;
            [
              (texlive.combine {
                inherit (texlive)
                  # Base package
                  scheme-small

                  # Build tools
                  latexmk

                  # Libraries (add as needed)
                ;
              })
            ];
        };
      });
}
