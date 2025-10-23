#!/bin/sh
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */ 
# Wallpaper selector (SUPER + W)

# WALLPAPERS PATH
wallDIR="$HOME/Pictures/wallpapers"

# Variables
SCRIPTSDIR="$HOME/.config/hypr/scripts"
focused_monitor=$(hyprctl monitors | awk '/^Monitor/{name=$2} /focused: yes/{print name}')

# swww transition config
FPS=144
TYPE="any"
DURATION=2
BEZIER=".43,1.19,1,.4"
SWWW_PARAMS=(--transition-fps "$FPS" --transition-type "$TYPE" --transition-duration "$DURATION")

# 🧠 SAFE retrieval of image files (null-separated, preserves spaces/quotes)
mapfile -d '' PICS < <(find "$wallDIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.gif' \) -print0)

RANDOM_PIC="${PICS[RANDOM % ${#PICS[@]}]}"
RANDOM_PIC_NAME=". random"

# Rofi command
rofi_command=(rofi -i -show -dmenu -config ~/.config/rofi/config-wallpaper.rasi)

# Sorting Wallpapers
menu() {
  # Start with the ". random" entry
  printf "%s\n" "$RANDOM_PIC_NAME"

  # Sort file list safely without breaking on spaces
  printf '%s\0' "${PICS[@]}" | sort -z | while IFS= read -r -d '' pic_path; do
    pic_name=$(basename "$pic_path")
    display_name="${pic_name%.*}"

    # Escape any rofi-breaking control characters
    display_name=${display_name//\\/\\\\}  # escape backslashes
    display_name=${display_name//\'/\\\'}  # escape single quotes
    display_name=${display_name//\"/\\\"}  # escape double quotes

    if [[ "${pic_name,,}" =~ \.gif$ ]]; then
      printf "%s\n" "$display_name"
    else
      printf "%s\x00icon\x1f%s\n" "$display_name" "$pic_path"
    fi
  done
}

# Start swww if not running
swww query >/dev/null 2>&1 || swww-daemon --format xrgb

main() {
  choice=$(menu | "${rofi_command[@]}")

  # No choice
  [[ -z $choice ]] && exit 0

  # Random choice
  if [[ "$choice" == "$RANDOM_PIC_NAME" ]]; then
    RANDOM_PIC="${PICS[RANDOM % ${#PICS[@]}]}"
    swww img -o "$focused_monitor" "$RANDOM_PIC" "${SWWW_PARAMS[@]}"
    exit 0
  fi

  # Find selected file safely
  for pic_path in "${PICS[@]}"; do
    filename=$(basename "$pic_path")
    if [[ "$filename" == "$choice"* ]]; then
      swww img -o "$focused_monitor" "$pic_path" "${SWWW_PARAMS[@]}"
      exit 0
    fi
  done

  echo "Image not found."
  exit 1
}

# Close running rofi if open
if pidof rofi >/dev/null; then
  pkill rofi
  exit 0
fi

main

