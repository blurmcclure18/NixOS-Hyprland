{ configs, pkgs, ... }:

{
  imports = [
    ./colors-alacritty.nix
    ./colors-hypridle.nix
    ./colors-hyprland.nix
    ./colors-rofi.nix
    ./colors-waybar.nix
  ];
}

