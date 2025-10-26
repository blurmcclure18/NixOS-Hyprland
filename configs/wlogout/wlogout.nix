{ configs, pkgs, ... }:

{
  home.file.".config/wlogout/layout".source = ./source_files/layout;

  home.file.".config/wlogout/style.css".source = ./source_files/style.css;
}

