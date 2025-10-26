{configs, pkgs, ... }:

{
  imports = [
    ./scripts.nix
    ./hypridle.nix
    ./hyprlock.nix
  ];
  
  home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;

 home.packages = with pkgs; [
  cliphist
  hyprlock
  hypridle
  rofi-wayland
  swww
  wallust
  walker
  waybar
  wl-clipboard
  wlogout
  wlr-randr
 ];

}
