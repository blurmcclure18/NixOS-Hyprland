{ config, pkgs, ... }:

{
  home.file.".config/hypr/scripts/MediaCtrl.sh" = {
    executable = true;
    text = builtins.replaceStrings ["__DOLLAR__"] ["$"] ''
      #!/bin/sh
      # /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
      # Playerctl

      # Source Colors
      colors="__DOLLAR__HOME/.config/rofi/wallust/colors-rofi.rasi"
      
      # Extract color3 value and make it bash-friendly
      color3=$(grep -E 'color3:' "__DOLLAR__colors" | sed -E 's/.*color3:\s*(#[0-9A-Fa-f]+);.*/\1/')
      
      sDIR="__DOLLAR__HOME/.config/hypr/scripts"
      
      # Send Notification
      notification() {
          notify_color=__DOLLAR__{color3/#\#/}
          text1="__DOLLAR__1"
          text2="__DOLLAR__2"
          hyprctl dismissnotify && hyprctl notify -1 3000 "rgb(__DOLLAR__notify_color)" "fontsize:12 __DOLLAR__text1 __DOLLAR__text2"
      }
      
      # Play the next track
      play_next() {
        playerctl next
        show_music_notification
      }
      
      # Play the previous track
      play_previous() {
        playerctl previous
        show_music_notification
      }
      
      # Toggle play/pause
      toggle_play_pause() {
        playerctl play-pause
        sleep 0.1
        show_music_notification
      }
      
      # Stop playback
      stop_playback() {
        playerctl stop
        notification "Playback:" "Stopped"
      }
      
      # Display notification with song information
      show_music_notification() {
        status=$(playerctl status)
        if [[ "__DOLLAR__status" == "Playing" ]]; then
          song_artist=$(playerctl metadata artist)
          notification "Now Playing:" "__DOLLAR__song_artist"
        elif [[ "__DOLLAR__status" == "Paused" ]]; then
          notification "Playback:" "Paused"
        fi
      }
      
      # Get media control action from command line argument
      case "__DOLLAR__1" in
      "--nxt")
        play_next
        ;;
      "--prv")
        play_previous
        ;;
      "--pause")
        toggle_play_pause
        ;;
      "--stop")
        stop_playback
        ;;
      *)
        echo "Usage: __DOLLAR__0 [--nxt|--prv|--pause|--stop]"
        exit 1
        ;;
      esac
    '';
  };
}

