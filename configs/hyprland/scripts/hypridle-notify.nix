{config, pkgs, ... }:

{
  home.file.".config/hypr/scripts/hypridle-notify.sh".text = 
  ''
    #!/bin/sh

    source $HOME/.config/hypr/wallust/wallust-hypridle.conf
    
    hypridle_warn () {
      hyprctl dismissnotify && hyprctl notify -1 6000 $color3 "fontsize:15 You are Idle!"
    }
    
    hypridle_resume () {
      hyprctl dismissnotify && hyprctl notify -1 6000 $color3 "fontsize:15 Oh! You're Back"
    }
    
    if [[ "$1" == "--warn" ]]; then
      hypridle_warn
    elif [[ "$1" == "--resume" ]]; then
      hypridle_resume
    else
      exit
    fi
  '';
}
