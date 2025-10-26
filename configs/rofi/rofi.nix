{ configs, pkgs, ... }

{
  imports = [
    ./config.nix
    ./0-shared-fonts.nix
    ./config-wallpaper.nix
    ./config-rofi-Beats.nix
    ./config-rofi-theme.nix
    ./config-rofi-Beats-menu.nix
  ];

  imports = builtins.attrValues (import ./themes);
}

