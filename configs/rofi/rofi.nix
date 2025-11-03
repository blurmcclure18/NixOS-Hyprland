{ configs, pkgs, lib, ... }:

{
  imports = [
    ./config.nix
    ./0-shared-fonts.nix
    ./config-wallpaper.nix
    ./config-rofi-Beats.nix
    ./config-rofi-theme.nix
    ./config-rofi-Beats-menu.nix
    ./config-waybar-layout.nix
    ./config-waybar-style.nix
  ];
}

