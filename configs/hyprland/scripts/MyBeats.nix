{ config, pkgs, ... }:

{
  home.file.".config/hypr/scripts/MyBeats.sh" = {
    executable = true;
    text =  ''
      #!/bin/sh

      # Source Colors
      source $HOME/.config/hypr/wallust/wallust-hypridle.conf

      sDIR="$HOME/.config/hypr/scripts"
      
      # Send Notification
      notification() {
          notify_color=$color3
      
          text1="$1"
          text2="$2"
          
          hyprctl dismissnotify && hyprctl notify -1 10000 $notify_color "fontsize:12 $text1 $text2"
          }
      
      
      music_playing() {
          pgrep -x "mpv" > /dev/null
      }
      
      stop_music() {
        notification "Music" "Stopped"
        mpv_pids=$(pgrep -x mpv)
      
        if [ -n "$mpv_pids" ]; then
          # Get the PID of the mpv process used by mpvpaper (using the unique argument added)
          mpvpaper_pid=$(ps aux | grep -- 'unique-wallpaper-process' | grep -v 'grep' | awk '{print $2}')
      
          for pid in $mpv_pids; do
            if ! echo "$mpvpaper_pid" | grep -q "$pid"; then
              kill -9 $pid || true 
            fi
          done
        fi
      }
      
      play_music() {
        notification "Now Playing:" "Lofi Girl"

        lofi_beats="$HOME/Music/lofi_beats.mp3"

        if [ -f $lofi_beats ]; then
          mpv --volume=60 --loop-file=inf --start=$(shuf -i 0-35999 -n 1) $lofi_beats
        else
          # Play the selected online music using mpv
          mpv --vid=no "$lofi_link"
        fi
      }
      
      main() {
        if music_playing; then
          stop_music
        else
          play_music
        fi
      }
      
      main
      '';
  };
}

