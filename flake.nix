{
  description = "A collection of templates for development projects";

  outputs = { self }: {
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
        description = "A Rust project managed by Cargo and integrated to Nix with nix-cargo-integration";
      };
    };
  };
}
