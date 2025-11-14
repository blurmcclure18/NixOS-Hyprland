{config, lib, pkgs, ... }:
{
  # Ensure tzdata is exposed where Horizon expects
  # Force /etc/zoneinfo to use the existing tzdata path
  environment.etc."zoneinfo".source = lib.mkForce "/nix/store/f7yb9lhi1z8dk4x8gy3c5xf3gvn3yi1s-tzdata-2025b/share/zoneinfo";

  # Create persistent symlink from /usr/share/zoneinfo -> /etc/zoneinfo
  system.activationScripts.zoneinfo-symlink.text = ''
    #!/bin/sh
    set -e
    if [ ! -L /usr/share/zoneinfo ]; then
      mkdir -p /usr/share
      ln -s /etc/zoneinfo /usr/share/zoneinfo
    fi
  '';
}

