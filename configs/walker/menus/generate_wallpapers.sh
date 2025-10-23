#!/bin/sh

# Define the directory containing your wallpapers
WALLPAPER_DIR="$HOME/Pictures/wallpapers"

# Use dmenu to present a list of files and capture the user's selection
SELECTED_WALLPAPER=$(find "$WALLPAPER_DIR" -type f -regex ".*\.\(png\|jpg\|jpeg\)" | dmenu)

# Check if a wallpaper was selected (dmenu returns empty string on cancel)
if [ -n "$SELECTED_WALLPAPER" ]; then
    # Use swww to set the chosen wallpaper
    swww img "$SELECTED_WALLPAPER"
fi

