{ configs, pkgs, ... }:

{
  home.file.".config/waybar/style.css".source = ./source_files/style.css;
#  home.file.".config/waybar/style/Original.css".source = ./source_files/style.css;
#  home.file.".config/waybar/style/Wallust_Transparent_Crystal_Clear.css".source = ./test_files/style/Wallust_Transparent_CrystalClear.css;
}

