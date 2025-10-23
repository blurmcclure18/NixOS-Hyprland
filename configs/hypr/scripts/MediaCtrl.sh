#!/bin/sh
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Playerctl

# Source Colors
colors="$HOME/.config/rofi/wallust/colors-rofi.rasi"

# Extract color3 value and make it bash-friendly
color3=$(grep -E 'color3:' "$colors" | sed -E 's/.*color3:\s*(#[0-9A-Fa-f]+);.*/\1/')

sDIR="$HOME/.config/hypr/scripts"

# Send Notification
notification() {
    notify_color=${color3/#\#/}

    text1="$1"
    text2="$2"
    
    hyprctl dismissnotify && hyprctl notify -1 3000 "rgb($notify_color)" "fontsize:12 $text1 $text2"
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
  #notify-send -e -u low -i $music_icon " Playback:" " Stopped"
}

# Display notification with song information
show_music_notification() {
  status=$(playerctl status)
  if [[ "$status" == "Playing" ]]; then

    #song_title=$(playerctl metadata title)
    song_artist=$(playerctl metadata artist)

    notification "Now Playing:" "$song_artist"

  elif [[ "$status" == "Paused" ]]; then
    notification "Playback:" "Paused"
    #notify-send -e -u low -i $music_icon " Playback:" " Paused"
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
