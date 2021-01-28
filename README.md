# Nix flake templates for flake-enabled projects

I kinda got tired of having to copy `flake.nix` etc. around from different projects
to start new ones that have flake outputs,
so this flake gathers structures from other projects I have for various languages.

To use a template when creating a flake project of your own, run
```shell
$ nix flake init -t github:i077/flake-templates#template-name
```
