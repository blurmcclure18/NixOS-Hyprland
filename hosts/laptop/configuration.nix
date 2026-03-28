{ config, lib, pkgs, unstable, self, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
	./hardware-configuration.nix
	../home-desktop/steam.nix
	../System_Configs
    ];

  networking.hostName = "laptop-nixos"; # Define your hostname.

  # Enable Podman
  virtualisation.podman.enable = true;

  # Ensure Systemd-resolved is enabled for VPN DNS handling
  services.resolved.enable = true;

  # Host Specific packages
  environment.systemPackages = with pkgs; [
    distrobox

  ] ++ (with unstable; [
    steam
    itch

  ]);

}
