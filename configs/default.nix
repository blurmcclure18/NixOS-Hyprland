{ configs, pkgs, ... }:

{
  imports = [
	./alacritty
	./gophertube
	./hyprland/hyprland.nix
	./mpv/mpv.nix
	./rofi
	./wallust
	./waybar
	./wlogout
	./zsh
  ];
}

