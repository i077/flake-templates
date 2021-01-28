{
  description = "A collection of templates for development projects";

  outputs = { self }: {
    templates = {
      python-poetry = {
        path = ./python-poetry;
        description = "A python project managed with Poetry";
      };
      python-mach-nix = {
        path = ./python-mach-nix;
        description = "A python project managed with mach-nix";
      };
    };
  };
}
