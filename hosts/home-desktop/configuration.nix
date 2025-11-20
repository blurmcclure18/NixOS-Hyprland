## Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, unstable, self, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
	./hardware-configuration.nix
	./star-citizen.nix
	./steam.nix
	../System_Configs
    ];

  networking.hostName = "home-nixos"; # Define your hostname.

    # Host Specific packages
  environment.systemPackages = with pkgs; [

  ] ++ (with unstable; [


  ]);

}
