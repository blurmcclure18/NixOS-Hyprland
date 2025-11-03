{ configs, pkgs, ... }:

{
  imports = [
    ./MyBeats.nix
    ./MyBrightness.nix
    ./MyVolume.nix
    ./MediaCtrl.nix ./hypridle-notify.nix
    ./Refresh.nix
    ./RofiPowerProfiles-selector.nix
    ./RofiThemeSelector-modified.nix
    ./Sounds.nix
    ./WallpaperSelect.nix
    ./WallustSwww.nix
    ./WaybarCava.nix
    ./WaybarLayout.nix
    ./WaybarStyles.nix
 
  ];
}

