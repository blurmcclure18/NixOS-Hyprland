{configs, pkgs, ... }:

{
  home.file.".config/hypr/scripts/WallpaperSelect.sh" = {
    executable = true;
    text = 
      builtins.replaceStrings ["__QUOTE__"] ["'"]
      (builtins.replaceStrings ["__DOLLAR__"] ["$"]
        '' 
        #!/bin/sh
        # /* ---- 💫 https://github.com/JaKooLit 💫 ---- */ 
        # Wallpaper selector (SUPER + W)
        
        set -euo pipefail
        
        # WALLPAPERS PATH
        wallDIR="__DOLLAR__HOME/Pictures/wallpapers"
        
        # Variables
        SCRIPTSDIR="__DOLLAR__HOME/.config/hypr/scripts"
        focused_monitor=__DOLLAR__(hyprctl monitors | awk '/^Monitor/{name=__DOLLAR__2} /focused: yes/{print name}')
        
        # swww transition config
        FPS=144
        TYPE="any"
        DURATION=2
        BEZIER=".43,1.19,1,.4"
        SWWW_PARAMS=(--transition-fps "__DOLLAR__FPS" --transition-type "__DOLLAR__TYPE" --transition-duration "__DOLLAR__DURATION")
        
        # 🧠 SAFE retrieval of image files (null-separated, preserves spaces/quotes)
        mapfile -d '__QUOTE__ PICS < <(find "__DOLLAR__wallDIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.gif' \) -print0)
        
        RANDOM_PIC="__DOLLAR__{PICS[RANDOM % __DOLLAR__{#PICS[@]}]}"
        RANDOM_PIC_NAME=". random"
        
        # Rofi command
        rofi_command=(rofi -i -show -dmenu -config ~/.config/rofi/config-wallpaper.rasi)
        
        # Sorting Wallpapers
        menu() {
          # Start with the ". random" entry
          printf "%s\n" "__DOLLAR__RANDOM_PIC_NAME"
        
          # Sort file list safely without breaking on spaces
          printf '%s\0' "__DOLLAR__{PICS[@]}" | sort -z | while IFS= read -r -d '__QUOTE__ pic_path; do
            pic_name=__DOLLAR__(basename "__DOLLAR__pic_path")
            display_name="__DOLLAR__{pic_name%.*}"
        
            # Escape any rofi-breaking control characters
            display_name=__DOLLAR__{display_name//\\/\\\\}  # escape backslashes
            display_name=__DOLLAR__{display_name//\'/\\\'}  # escape single quotes
            display_name=__DOLLAR__{display_name//\"/\\\"}  # escape double quotes
        
            if [[ "__DOLLAR__{pic_name,,}" =~ \.gif__DOLLAR__ ]]; then
              printf "%s\n" "__DOLLAR__display_name"
            else
              printf "%s\x00icon\x1f%s\n" "__DOLLAR__display_name" "__DOLLAR__pic_path"
            fi
          done
        }
        
        # Start swww if not running
        swww query >/dev/null 2>&1 || swww-daemon --format xrgb
        
        run_refresh() {
          # Define file_exists function
          file_exists() {
              if [ -e "__DOLLAR__1" ]; then
                  return 0  # File exists
              else
                  return 1  # File does not exist
              fi
          }
          
        #  # Kill already running processes
        #  _ps=(waybar rofi)
        #  for _prs in "__DOLLAR__{_ps[@]}"; do
        #      if pidof "__DOLLAR__{_prs}" >/dev/null; then
        #          pkill "__DOLLAR__{_prs}"
        #      fi
        #  done
          
          # added since wallust sometimes not applying
          #echo "Stopping Waybar"
          #killall -SIGUSR2 waybar 
          
        #  # some process to kill
        #  for pid in __DOLLAR__(pidof waybar rofi); do
        #      echo "Stopping __DOLLAR__pid ???"
        #      kill -SIGUSR1 "__DOLLAR__pid"
        #  done
        }
        
        run_wallust() {
          # Inputs and paths
          passed_path="__DOLLAR__{1:-}"
          cache_dir="__DOLLAR__HOME/.cache/swww/"
          rofi_link="__DOLLAR__HOME/.config/rofi/.current_wallpaper"
          wallpaper_current="__DOLLAR__HOME/.config/hypr/wallpaper_effects/.wallpaper_current"
          
          # Helper: get focused monitor name (prefer JSON)
          get_focused_monitor() {
            if command -v jq >/dev/null 2>&1; then
              hyprctl monitors -j | jq -r '.[] | select(.focused) | .name'
            else
              hyprctl monitors | awk '/^Monitor/{name=__DOLLAR__2} /focused: yes/{print name}'
            fi
          }
          
          # Determine wallpaper_path
          wallpaper_path=""
          if [[ -n "__DOLLAR__passed_path" && -f "__DOLLAR__passed_path" ]]; then
            wallpaper_path="__DOLLAR__passed_path"
          else
            # Try to read from swww cache for the focused monitor, with a short retry loop
            current_monitor="__DOLLAR__(get_focused_monitor)"
            cache_file="__DOLLAR__cache_dir__DOLLAR__current_monitor"
          
            # Wait briefly for swww to write its cache after an image change
            for i in {1..10}; do
              if [[ -f "__DOLLAR__cache_file" ]]; then
                break
              fi
              sleep 0.1
            done
          
            if [[ -f "__DOLLAR__cache_file" ]]; then
              # The first non-filter line is the original wallpaper path
              wallpaper_path="__DOLLAR__(grep -v 'Lanczos3' "__DOLLAR__cache_file" | head -n 1)"
            fi
          fi
          
          if [[ -z "__DOLLAR__{wallpaper_path:-}" || ! -f "__DOLLAR__wallpaper_path" ]]; then
            # Nothing to do; avoid failing loudly so callers can continue
            exit 0
          fi
          
          # Update helpers that depend on the path
          ln -sf "__DOLLAR__wallpaper_path" "__DOLLAR__rofi_link" || true
          mkdir -p "__DOLLAR__(dirname "__DOLLAR__wallpaper_current")"
          cp -f "__DOLLAR__wallpaper_path" "__DOLLAR__wallpaper_current" || true
          
          # Run wallust (silent) to regenerate templates defined in ~/.config/wallust/wallust.toml
          # -s is used in this repo to keep things quiet and avoid extra prompts
          wallust run -s "__DOLLAR__wallpaper_path" || true
        
        }
        
        main() {
          choice=__DOLLAR__(menu | "__DOLLAR__{rofi_command[@]}")
        
          # No choice
          [[ -z __DOLLAR__choice ]] && exit 0
        
          # Random choice
          if [[ "__DOLLAR__choice" == "__DOLLAR__RANDOM_PIC_NAME" ]]; then
            RANDOM_PIC="__DOLLAR__{PICS[RANDOM % __DOLLAR__{#PICS[@]}]}"
            swww img -o "__DOLLAR__focused_monitor" "__DOLLAR__RANDOM_PIC" "__DOLLAR__{SWWW_PARAMS[@]}"
            #exit 0
          fi
        
          # Find selected file safely
          for pic_path in "__DOLLAR__{PICS[@]}"; do
            filename=__DOLLAR__(basename "__DOLLAR__pic_path")
            if [[ "__DOLLAR__filename" == "__DOLLAR__choice"* ]]; then
              swww img -o "__DOLLAR__focused_monitor" "__DOLLAR__pic_path" "__DOLLAR__{SWWW_PARAMS[@]}"
              #exit 0
            fi
          done
        
          sleep 0.5
          #__DOLLAR__HOME/.config/hypr/scripts/WallustSwww.sh
          run_wallust
        
          sleep 0.2
          #__DOLLAR__HOME/.config/hypr/scripts/Refresh.sh
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
        '');
  };
}
