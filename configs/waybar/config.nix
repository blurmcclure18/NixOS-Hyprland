{ configs, pkgs, ... }:

{
  home.file.".config/waybar/config.jsonc".source = ./source_files/config.jsonc;

  # Omarchy Logo
  home.file.".local/share/fonts/omarchy.tty".source = ./source_files/omarchy.ttf;

  # Test Configs
#  home.file.".config/waybar/configs/SummitSplit".source = ./test_files/configs/TOP_BOT_SummitSplit;
#  home.file.".config/waybar/configs/Original".source = ./source_files/config.jsonc;
#  home.file.".config/waybar/modules".source = ./test_files/modules;
}

