{ configs, pkgs, ... }:

{
  home.file.".config/wlogout/layout".source = ./source_files/layout;

  home.file.".config/wlogout/style.css".source = ./source_files/style.css;

  home.file.".config/wlogout/icons/lock.png".source = ./source_files/icons/lock.png;
<<<<<<< HEAD
  home.file.".config/wlogout/icons/power.png".source = ./source_files/icons/power.png;
  home.file.".config/wlogout/icons/sleep.png".source = ./source_files/icons/sleep.png;
  home.file.".config/wlogout/icons/logout.png".source = ./source_files/icons/logout.png;
  home.file.".config/wlogout/icons/restart.png".source = ./source_files/icons/restart.png;
=======

  home.file.".config/wlogout/icons/power.png".source = ./source_files/icons/power.png;

  home.file.".config/wlogout/icons/sleep.png".source = ./source_files/icons/sleep.png;

  home.file.".config/wlogout/icons/logout.png".source = ./source_files/icons/logout.png;
  
  home.file.".config/wlogout/icons/restart.png".source = ./source_files/icons/restart.png;

>>>>>>> 89c319a1ea2eef9a2259235a562642e01ee071f6
  home.file.".config/wlogout/icons/hibernate.png".source = ./source_files/icons/hibernate.png;
}

