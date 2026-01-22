{ configs, pkgs, ... }:

{
  home.file.".config/hypr/scripts/Hypridle.sh" = {
	executable = true;
	text = '' 
		#!/bin/sh
		# This is for custom version of waybar idle_inhibitor which activates / deactivates hypridle instead

		source $HOME/.config/hypr/wallust/wallust-hypridle.conf

		# convert color for hyprctl
		notify_color=$color3
		
		PROCESS="hypridle"
		
		if [[ "$1" == "status" ]]; then
		    sleep 1
		    if pgrep -x "$PROCESS" >/dev/null; then
		        echo '{"text": "RUNNING", "class": "active", "tooltip": "idle_inhibitor NOT ACTIVE\nLeft Click: Activate\nRight Click: Lock Screen"}'
		    else
		        echo '{"text": "NOT RUNNING", "class": "notactive", "tooltip": "idle_inhibitor is ACTIVE\nLeft Click: Deactivate\nRight Click: Lock Screen"}'
		    fi
		elif [[ "$1" == "toggle" ]]; then
		    if pgrep -x "$PROCESS" >/dev/null; then
		        pkill "$PROCESS"
			echo "Killed $PROCESS"
			hyprctl dismissnotify && hyprctl notify -1 5000 $notify_color "fontsize:15 Stopped Hypridle"

		    else
			hyprctl dismissnotify && hyprctl notify -1 5000 $notify_color "fontsize:15 Started Hypridle"
		        "$PROCESS"
		    fi
		else
		    echo "Usage: $0 {status|toggle}"
		    exit 1
		fi
	'';
  };
}
