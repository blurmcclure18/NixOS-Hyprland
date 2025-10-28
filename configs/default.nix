{ configs, pkgs, ... }:

{
  imports = [
	./alacritty
	./hyprland/hyprland.nix
	./mpv/mpv.nix
	./rofi
	./wallust
	./waybar
	./wlogout
	./zsh
  ];
}

