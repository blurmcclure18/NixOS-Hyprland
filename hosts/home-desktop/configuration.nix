## Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, inputs, lib, pkgs, unstable, self, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
	./games.nix
	./hardware-configuration.nix
	./nvidia.nix
	./star-citizen.nix
	./steam.nix
	../System_Configs
    ];

 # boot.loader.systemd-boot.extraEntries = {
 #       "windows.conf" = '' 
 #       	title Windows 11
 #       	efi /EFI/Microsoft/Boot/bootmgfw.efi
 #       '';
 # };

  boot.kernelPackages = pkgs.linuxPackages_6_18;

  networking.hostName = "home-nixos"; # Define your hostname.
  networking.nameservers = ["1.1.1.1" "8.8.8.8"];

    # Host Specific packages
  environment.systemPackages = with pkgs; [
	dconf
	dejavu_fonts
	fontconfig
	gsettings-desktop-schemas
	gtk3
	glib
	gocryptfs
	itch
	protonvpn-gui
	transmission_4-qt
	unrar
	# wineWowPackages.stable
	# wineWowPackages.waylandFull
	# winetricks
	zenity

  ] ++ (with unstable; [
	wineWow64Packages.stable
	winetricks

  ]);

}
