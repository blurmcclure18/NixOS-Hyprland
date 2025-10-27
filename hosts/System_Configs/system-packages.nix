{configs, lib, pkgs, unstable, ... }:

{
  environment.systemPackages = with pkgs; [
	acpi
	adwaita-icon-theme
	bluetui
	bluez
	btop
	brightnessctl
	curl
	firefox
	fzf
	git
	gnumake
	impala
	mpv
	neovim
	netowrkmanagerapplet
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
	hyprmon
	omnissa-horizon-client
	wiremix
  ]);
}
