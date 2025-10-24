{ config, pkgs, ... }:

{
  home.file.".config/hypr/scripts/MyBeats.sh" = {
    executable = true;
    text = builtins.replaceStrings ["__DOLLAR__"] ["$"] ''
      #!/bin/sh

      # Source Colors
      colors="__DOLLAR__HOME/.config/rofi/wallust/colors-rofi.rasi"
      
      # Extract color3 value and make it bash-friendly
      color3=__DOLLAR__(grep -E 'color3:' "$colors" | sed -E 's/.*color3:\s*(#[0-9A-Fa-f]+);.*/\1/')
      
      lofi_link="https://www.youtube.com/live/jfKfPfyJRdk?si=PnJIA9ErQIAw6-qd"
      
      sDIR="__DOLLAR__HOME/.config/hypr/scripts"
      
      # Send Notification
      notification() {
          notify_color=__DOLLAR__{color3/#\#/}
      
          text1="__DOLLAR__1"
          text2="__DOLLAR__2"
          
          hyprctl dismissnotify && hyprctl notify -1 10000 "rgb(__DOLLAR__notify_color)" "fontsize:12 $text1 $text2"
      }
      
      music_playing() {
          pgrep -x "mpv" > /dev/null
      }
      
      stop_music() {
        notification "Music" "Stopped"
        mpv_pids=__DOLLAR__(pgrep -x mpv)
      
        if [ -n "__DOLLAR__mpv_pids" ]; then
          # Get the PID of the mpv process used by mpvpaper (using the unique argument added)
          mpvpaper_pid=__DOLLAR__(ps aux | grep -- 'unique-wallpaper-process' | grep -v 'grep' | awk '{print $2}')
      
          for pid in __DOLLAR__mpv_pids; do
            if ! echo "__DOLLAR__mpvpaper_pid" | grep -q "$pid"; then
              kill -9 __DOLLAR__pid || true 
            fi
          done
        fi
      }
      
      play_music() {
        notification "Now Playing:" "Lofi Girl"
      
        # Play the selected online music using mpv
        mpv --vid=no "__DOLLAR__lofi_link"
      }
      
      main() {
        if music_playing; then
          stop_music
        else
          play_music
        fi
      }
      
      main    '';
  };
}

