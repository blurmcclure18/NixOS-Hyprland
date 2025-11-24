{ configs, pkgs, ... }:

{
  imports = [
    ./config.nix
    ./modules.nix
    ./style.nix
  ];
}

