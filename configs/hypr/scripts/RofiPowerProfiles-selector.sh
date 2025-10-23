#!/bin/sh


# Get list of profiles
profiles=$'performance\nbalanced\npower-saver'

# Get current profile
current=$(powerprofilesctl get)

# Show menu with current profile preselected
chosen=$(echo "$profiles" | rofi -dmenu -p "Power Profile (current: $current)" -theme ~/.config/rofi/themes/KooL_style-9.rasi )

#chosen=$(echo -e "$profiles" | walker --dmenu --theme dmenu_250 )

# If user cancels, exit
[ -z "$chosen" ] && exit 0

# Set the chosen profile
powerprofilesctl set "$chosen"

# Load colors from wallust-hyprland.conf
while IFS='=' read -r key value; do
  key=$(echo "$key" | xargs)
  value=$(echo "$value" | xargs)
  [[ -z "$key" || "$key" == \#* ]] && continue
  key="${key#\$}"        # remove leading $
  eval "${key}='${value}'"
done < ../wallust/wallust-hyprland.conf

# Convert color for hyprctl
notify_color=${color3//rgb(/0x}
notify_color=${notify_color//)}       # remove trailing parenthesis

# Optional: default fallback
notify_color=${notify_color:-0xFFFFFF}

# Confirm visually
hyprctl notify 5 10000 "$notify_color" "fontsize:25 Power Profile Set: Profile changed to: $chosen"
