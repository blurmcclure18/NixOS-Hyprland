{ config, pkgs, ... }:

{
  home.file.".config/hypr/scripts/MediaCtrl.sh" = {
    executable = true;
    text = builtins.replaceStrings ["$"] ["$"] ''
      #!/bin/sh
      # /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
      # Playerctl

      # Source Colors
      source $HOME/.config/hypr/wallust/wallust-hypridle.conf

      sDIR="$HOME/.config/hypr/scripts"
      
      # Send Notification
      notification() {
          notify_color=$color3
          text1="$1"
          text2="$2"
          hyprctl dismissnotify && hyprctl notify -1 3000 $notify_color "fontsize:12 $text1 $text2"
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
        sleep 0.3
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
        if [[ "$status" == "Playing" ]]; then
          song_artist=$(playerctl metadata artist)
          notification "Now Playing:" "$song_artist"
        elif [[ "$status" == "Paused" ]]; then
          notification "Playback:" "Paused"
        fi
      }
      
      # Get media control action from command line argument
      case "$1" in
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
        echo "Usage: $0 [--nxt|--prv|--pause|--stop]"
        exit 1
        ;;
      esac
    '';
  };
}

