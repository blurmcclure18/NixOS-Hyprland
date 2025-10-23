#!/bin/sh

# Source Colors
colors="$HOME/.config/rofi/wallust/colors-rofi.rasi"

# Extract color3 value and make it bash-friendly
color3=$(grep -E 'color3:' "$colors" | sed -E 's/.*color3:\s*(#[0-9A-Fa-f]+);.*/\1/')

lofi_link="https://www.youtube.com/live/jfKfPfyJRdk?si=PnJIA9ErQIAw6-qd"

sDIR="$HOME/.config/hypr/scripts"

# Send Notification
notification() {
    notify_color=${color3/#\#/}

    text1="$1"
    text2="$2"
    
    hyprctl dismissnotify && hyprctl notify -1 10000 "rgb($notify_color)" "fontsize:12 $text1 $text2"
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

  # Play the selected online music using mpv
  mpv --vid=no "$lofi_link"
}

main() {
  if music_playing; then
    stop_music
  else
    play_music
  fi
}

main
