## Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, unstable, self, ... }:
{

  imports =
    [ # Include the results of the hardware scan.
	./hardware-configuration.nix
	../System_Configs
    ];

  networking.hostName = "optiplex-nixos"; # Define your hostname.

  # Host Specific packages
  environment.systemPackages = with pkgs; [
    mindustry
    remmina

  ] ++ (with unstable; [
    omnissa-horizon-client


  ]);

}
