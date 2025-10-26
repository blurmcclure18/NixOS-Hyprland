{ configs, pkgs, ... }:

{
  home.file.".config/waybar/config.jsonc".source = ./source_files/config.jsonc;
}

