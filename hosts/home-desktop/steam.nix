{ config, pkgs, lib, ... }:

{
  programs.steam = {
 	 enable = true;
 	 remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
 	 dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
 	 localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
	 extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  programs.nix-ld.enable = true;

  programs.nix-ld.libraries = with pkgs; [
    alsa-lib
    atk
    cairo
    cups
    curl
    dbus
    dconf
    expat
    glib
    gsettings-desktop-schemas
    gtk3
    libdrm
    libgbm
    libGL
    libglvnd
    libpulseaudio
    libxkbcommon
    mesa
    nss
    nspr
    openssl
    pango
    protonup-rs
    protonup-qt
    stdenv.cc.cc
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xorg.libX11
    xorg.libxcb
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXtst
    zlib
  ];
}
