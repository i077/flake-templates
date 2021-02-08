{
  description = "A LaTeX project";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
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
