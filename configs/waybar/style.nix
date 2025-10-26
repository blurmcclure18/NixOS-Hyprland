{ configs, pkgs, ... }:

{
  home.file.".config/waybar/style.css".source = ./source_files/style.css;
}

