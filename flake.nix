{
  description = "A collection of templates for development projects";

  outputs = { self }: {
    templates = {
      python-poetry = {
        path = ./python-poetry;
        description = "A python project managed with Poetry";
      };
    };
  };
}
