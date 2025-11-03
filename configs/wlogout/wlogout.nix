{ configs, pkgs, ... }:

{
  # Config Files
  home.file.".config/wlogout/layout".source = ./test_files/layout;
  home.file.".config/wlogout/style.css".source = ./test_files/style.css;
  
  # Icon Files
  home.file.".config/wlogout/icons/lock.png".source = ./test_files/icons/lock.png;
  home.file.".config/wlogout/icons/power.png".source = ./test_files/icons/power.png;
  home.file.".config/wlogout/icons/sleep.png".source = ./test_files/icons/sleep.png;
  home.file.".config/wlogout/icons/logout.png".source = ./test_files/icons/logout.png;
  home.file.".config/wlogout/icons/restart.png".source= ./test_files/icons/restart.png;
  home.file.".config/wlogout/icons/hibernate.png".source = ./test_files/icons/hibernate.png;
}

