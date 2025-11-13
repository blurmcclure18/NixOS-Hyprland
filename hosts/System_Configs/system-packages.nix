{configs, lib, pkgs, unstable, ... }:

{
  environment.systemPackages = with pkgs; [
	acpi
	adwaita-icon-theme
	alacritty
	bluetui
	bluez
	btop
	brightnessctl
	curl
	discord
	firefox
	fzf
	git
	gnumake
	impala
	mpv
	neovim
	networkmanagerapplet
	nix-search-cli
	openconnect
	pamixer
	pavucontrol
	playerctl
	power-profiles-daemon
	python314
	ripgrep
	greetd.tuigreet
	vim
	wget
	unzip
	#vmware-horizon-client
	yazi
	yt-dlp
  ] ++ (with unstable; [
	omnissa-horizon-client
	wiremix
  ]);
}
