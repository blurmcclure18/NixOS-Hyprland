{ configs, pkgs, ... }:

{
  imports = [
	./alacritty
	./btop
	./ghostty
	./hyprland/hyprland.nix
	./mpv/mpv.nix
	./rofi
	./wallust
	./waybar
	./wlogout
	./zsh
  ];
}

