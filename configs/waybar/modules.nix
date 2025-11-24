{config, pkgs, ... }:
{
  home.file.".config/waybar/modules".source = ./source_files/modules;
}
