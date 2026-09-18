{ config, lib, pkgs, unstable, self, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
	./hardware-configuration.nix
	./keyd.nix
	./iio.nix
	../home-desktop/steam.nix
	../home-desktop/games.nix
	../System_Configs
    ];

  boot.kernelPackages = pkgs.linuxPackages_6_18;

  networking.hostName = "laptop-nixos"; # Define your hostname.

  # Enable Podman
  virtualisation.podman.enable = true;

  # Ensure Systemd-resolved is enabled for VPN DNS handling
  services.resolved.enable = true;

  # Host Specific packages
  environment.systemPackages = with pkgs; [
    distrobox

  ] ++ (with unstable; [
    omnissa-horizon-client
    steam
    itch

  ]);

}
