{configs, pkgs, ... }:

{
  home.file.".config/hypr/scripts/RofiPowerProfiles-selector.sh" = {
    executable = true;
    text = '' 
      #!/bin/sh
      
      # Get list of profiles
      profiles=$'performance\nbalanced\npower-saver'
      
      # Get current profile
      current=$(powerprofilesctl get)
      
      # Show menu with current profile preselected
      chosen=$(echo "$profiles" | rofi -dmenu -p "Power Profile (current: $current)" -theme $HOME/.config/rofi/themes/KooL_style-9.rasi )
      
      #chosen=$(echo -e "$profiles" | walker --dmenu --theme dmenu_250 )
      
      # If user cancels, exit
      [ -z "$chosen" ] && exit 0
      
      # Set the chosen profile
      powerprofilesctl set "$chosen"
      
      source $HOME/.config/hypr/wallust/wallust-hypridle.conf

      # Convert color for hyprctl
      notify_color=$color3
      
      # Confirm visually
      hyprctl dismissnotify && hyprctl notify 5 10000 $notify_color "fontsize:15 Power Profile Set: Profile changed to: $chosen"
    '';
  };
}
