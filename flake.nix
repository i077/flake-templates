{
  description = "A collection of templates for development projects";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    devshell.url = "github:numtide/devshell";
    treefmt.url = "github:numtide/treefmt";
  };

  outputs = { self, flake-utils, devshell, treefmt, nixpkgs }:
    {
      templates = {
        latex = {
          path = ./latex;
          description = "A LaTeX project";
        };

        python-poetry = {
          path = ./python-poetry;
          description = "A python project managed with Poetry";
        };

        python-mach-nix = {
          path = ./python-mach-nix;
          description = "A python project managed with mach-nix";
        };

        rust-cargo-integration = {
          path = ./rust-cargo-integration;
          description =
            "A Rust project managed by Cargo and integrated to Nix with nix-cargo-integration";
        };
      };
    } //
    # add basic devShell to pin CI workflows and
    # to provide formatting utilities for all templates
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ devshell.overlay ];
        };
        fmt = pkgs.writeShellScriptBin "treefmt" ''
          ${treefmt.defaultPackage.${system}}/bin/treefmt -q $@
        '';
      in
      {
        devShell = pkgs.devshell.mkShell {
          packages = with pkgs; [
            python3
            nixpkgs-fmt
            rustfmt
            black
          ];

          commands = [
            {
              help = "Format the entire code tree";
              name = "treefmt";
              category = "utilities";
              package = fmt;
            }
            {
              help = "run checks on all flake outputs";
              name = "checks";
              category = "utilities";
              command = "./checks";
            }
          ];
        };
      });
}
