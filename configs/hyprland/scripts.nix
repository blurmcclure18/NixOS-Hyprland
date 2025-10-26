{configs, pkgs, ... }:

{
# this file is only used for importing all the scripts into a single location then importing this file into hyprland.nix
  imports = [
    ./scripts/MyBeats.nix
    ./scripts/MyBrightness.nix
    ./scripts/MyVolume.nix
    ./scripts/MediaCtrl.nix
    ./scripts/hypridle-notify.nix
    ./scripts/Refresh.nix
    ./scripts/RofiPowerProfiles-selector.nix
    ./scripts/RofiThemeSelector-modified.nix
    ./scripts/Sounds.nix
    ./scripts/WallpaperSelect.nix
    ./scripts/WallustSwww.nix
  ];
}
