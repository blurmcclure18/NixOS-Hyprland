#!/bin/sh
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Scripts for brightness controls

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

brightness_get(){
  brightnessctl get
  notification "Brightness:" "$current_brightness"
}

brightness_up() {
  brightnessctl -e4 -n2 set 5%+ 
  current_brightness=$(brightnessctl get)
  notification "Brightness:" "$current_brightness"

}

brightness_down() {
  brightnessctl -e4 -n2 set 5%- 
  current_brightness=$(brightnessctl get)
  notification "Brightness:" "$current_brightness"
}

if [[ "$1" == "--up" ]]; then
  brightness_up
elif [[ "$1" == "--down" ]]; then
  brightness_down
else
  brightness_get
fi
