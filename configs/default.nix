{ configs, pkgs, ... }:

{
  imports = [
	./alacritty
	./btop
	./hyprland/hyprland.nix
	./mpv/mpv.nix
	./rofi
	./wallust
	./waybar
	./wlogout
	./zsh
  ];
}

