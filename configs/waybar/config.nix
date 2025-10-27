{ configs, pkgs, ... }:

{
  home.file.".config/waybar/config.jsonc".source = ./source_files/config.jsonc;

  # Omarchy Logo
  home.file.".local/share/fonts/omarchy.tty".source = ./source_files/omarchy.ttf;
}

