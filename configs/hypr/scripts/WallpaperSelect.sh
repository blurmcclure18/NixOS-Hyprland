#!/bin/sh
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */ 
# Wallpaper selector (SUPER + W)

set -euo pipefail

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

run_refresh() {
  # Define file_exists function
  file_exists() {
      if [ -e "$1" ]; then
          return 0  # File exists
      else
          return 1  # File does not exist
      fi
  }
  
#  # Kill already running processes
#  _ps=(waybar rofi)
#  for _prs in "${_ps[@]}"; do
#      if pidof "${_prs}" >/dev/null; then
#          pkill "${_prs}"
#      fi
#  done
  
  # added since wallust sometimes not applying
  #echo "Stopping Waybar"
  #killall -SIGUSR2 waybar 
  
#  # some process to kill
#  for pid in $(pidof waybar rofi); do
#      echo "Stopping $pid ???"
#      kill -SIGUSR1 "$pid"
#  done
}

run_wallust() {
  # Inputs and paths
  passed_path="${1:-}"
  cache_dir="$HOME/.cache/swww/"
  rofi_link="$HOME/.config/rofi/.current_wallpaper"
  wallpaper_current="$HOME/.config/hypr/wallpaper_effects/.wallpaper_current"
  
  # Helper: get focused monitor name (prefer JSON)
  get_focused_monitor() {
    if command -v jq >/dev/null 2>&1; then
      hyprctl monitors -j | jq -r '.[] | select(.focused) | .name'
    else
      hyprctl monitors | awk '/^Monitor/{name=$2} /focused: yes/{print name}'
    fi
  }
  
  # Determine wallpaper_path
  wallpaper_path=""
  if [[ -n "$passed_path" && -f "$passed_path" ]]; then
    wallpaper_path="$passed_path"
  else
    # Try to read from swww cache for the focused monitor, with a short retry loop
    current_monitor="$(get_focused_monitor)"
    cache_file="$cache_dir$current_monitor"
  
    # Wait briefly for swww to write its cache after an image change
    for i in {1..10}; do
      if [[ -f "$cache_file" ]]; then
        break
      fi
      sleep 0.1
    done
  
    if [[ -f "$cache_file" ]]; then
      # The first non-filter line is the original wallpaper path
      wallpaper_path="$(grep -v 'Lanczos3' "$cache_file" | head -n 1)"
    fi
  fi
  
  if [[ -z "${wallpaper_path:-}" || ! -f "$wallpaper_path" ]]; then
    # Nothing to do; avoid failing loudly so callers can continue
    exit 0
  fi
  
  # Update helpers that depend on the path
  ln -sf "$wallpaper_path" "$rofi_link" || true
  mkdir -p "$(dirname "$wallpaper_current")"
  cp -f "$wallpaper_path" "$wallpaper_current" || true
  
  # Run wallust (silent) to regenerate templates defined in ~/.config/wallust/wallust.toml
  # -s is used in this repo to keep things quiet and avoid extra prompts
  wallust run -s "$wallpaper_path" || true

}

main() {
  choice=$(menu | "${rofi_command[@]}")

  # No choice
  [[ -z $choice ]] && exit 0

  # Random choice
  if [[ "$choice" == "$RANDOM_PIC_NAME" ]]; then
    RANDOM_PIC="${PICS[RANDOM % ${#PICS[@]}]}"
    swww img -o "$focused_monitor" "$RANDOM_PIC" "${SWWW_PARAMS[@]}"
    #exit 0
  fi

  # Find selected file safely
  for pic_path in "${PICS[@]}"; do
    filename=$(basename "$pic_path")
    if [[ "$filename" == "$choice"* ]]; then
      swww img -o "$focused_monitor" "$pic_path" "${SWWW_PARAMS[@]}"
      #exit 0
    fi
  done

  sleep 0.5
  #$HOME/.config/hypr/scripts/WallustSwww.sh
  run_wallust

  sleep 0.2
  #$HOME/.config/hypr/scripts/Refresh.sh
  run_refresh

#  # Start waybar
#  echo "Starting Waybar..."
#  waybar &

  echo "Image not found."
  exit 1
}

# Close running rofi if open
if pidof rofi >/dev/null; then
  pkill rofi
  exit 0
fi

main

