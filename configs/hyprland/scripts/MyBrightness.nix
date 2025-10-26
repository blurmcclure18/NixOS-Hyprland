{configs, pkgs, ... }:

{
  home.file.".config/hypr/scripts/MyBrightness.sh" = {
    executable = true;
    text = ''
      #!/bin/sh
      # /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
      # Scripts for brightness controls
      
      # Source Colors
      source $HOME/.config/hypr/wallust/wallust-hypridle.conf

      sDIR="$HOME/.config/hypr/scripts"
      
      # Send Notification
      notification() {
          notify_color=$color3
      
          text1="$1"
          text2="$2"
          
          hyprctl dismissnotify && hyprctl notify -1 3000 $color3 "fontsize:12 $text1 $text2"
      }
      
      brightness_get(){
        brightnessctl -m | cut -d, -f4 | tr -d '%'
      }
      
      brightness_up() {
        brightnessctl -e4 -n2 set 5%+ 
        current_brightness=$(brightness_get)
        notification "Brightness:" "$current_brightness%" && "$sDIR/Sounds.sh" --volume
      
      }
      
      brightness_down() {
        brightnessctl -e4 -n2 set 5%- 
        current_brightness=$(brightness_get)
        notification "Brightness:" "$current_brightness%" && "$sDIR/Sounds.sh" --volume
      }
      
      if [[ "$1" == "--up" ]]; then
        brightness_up
      elif [[ "$1" == "--down" ]]; then
        brightness_down
      else
        brightness_get
      fi
    '';
  };
}
