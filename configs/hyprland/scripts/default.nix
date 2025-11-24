{ configs, pkgs, ... }:

{
  imports = [
    ./Hypridle.nix
    ./hypridle-notify.nix
    ./MyBeats.nix
    ./MyBrightness.nix
    ./MyVolume.nix
    ./MediaCtrl.nix 
    ./PanicButton.nix
    ./RandomVid.nix
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

