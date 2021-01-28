# Nix flake templates for flake-enabled projects

I kinda got tired of having to copy `flake.nix` etc. around from different projects
to start new ones that have flake outputs,
so this flake gathers structures from other projects I have for various languages.

To use a template when creating a flake project of your own, run
```shell
$ nix flake init -t github:i077/flake-templates#template-name
```
Better yet, if you're running NixOS, add this flake to your registry so you can use a shorter name like
```shell
$ nix flake init -t dev-templ#template-name
```

To do this, either add the following to your configuration:
```nix
{
  nix.registry.dev-templ.to = "github:i077/flake-templates";
}
```
or for an imperative approach, run
```shell
$ nix registry add dev-templ "github:i077/flake-templates"
```
