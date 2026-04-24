{ configs, pkgs, ... }:

{
  imports = [
	./alacritty
	./btop
	./ghostty
	./hyprland/hyprland.nix
	./mpv/mpv.nix
	./nvim
	./rofi
	./wallust
	./waybar
	./wlogout
	./zsh
  ];
}

