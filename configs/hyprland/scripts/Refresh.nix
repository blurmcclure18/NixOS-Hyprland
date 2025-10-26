{configs, pkgs, ... }:

{
  home.file.".config/hypr/scripts/Refresh.sh" = {
    executable = true;
    text = builtins.replaceStrings ["__DOLLAR__"] ["$"] '' 
      #!/bin/sh
      # /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
      # Scripts for refreshing ags, waybar, rofi, swaync, wallust
      
      # Define file_exists function
      file_exists() {
          if [ -e "__DOLLAR__1" ]; then
              return 0  # File exists
          else
              return 1  # File does not exist
          fi
      }
      
      # Kill already running processes
      _ps=(waybar rofi)
      for _prs in "__DOLLAR__{_ps[@]}"; do
          if pidof "__DOLLAR__{_prs}" >/dev/null; then
              pkill "__DOLLAR__{_prs}"
          fi
      done
      
      # added since wallust sometimes not applying
      killall -SIGUSR2 waybar 
      
      # some process to kill
      for pid in __DOLLAR__(pidof waybar rofi); do
          kill -SIGUSR1 "__DOLLAR__pid"
      done
      
      #Restart waybar
      sleep 1
      waybar &
      
      exit 0
    '';
  };
}
