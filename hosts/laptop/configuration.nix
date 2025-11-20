{ config, lib, pkgs, unstable, self, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
	./hardware-configuration.nix
	../System_Configs
    ];

  networking.hostName = "laptop-nixos"; # Define your hostname.

    # Host Specific packages
  environment.systemPackages = with pkgs; [

  ] ++ (with unstable; [


  ]);

}
