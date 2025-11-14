{config, lib, ... }:
{
  # Ensure tzdata is exposed where Horizon expects
  environment.etc."zoneinfo".source = pkgs.tzdata;

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

