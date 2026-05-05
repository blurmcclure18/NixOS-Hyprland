{ config, pkgs, ... }:

{
  home.file.".config/hypr/scripts/MyVids.sh" = {
    executable = true;
    text =  ''
	#!/bin/sh

	source $HOME/.config/hypr/wallust/wallust-hypridle.conf
	notify_color=$color3
	
	ENC="$HOME/Videos/myvids/.Hidden-gocryptfs"
	MNT="$HOME/Videos/myvids/Private"
	
	mkdir -p "$MNT"
	
	is_mounted() {
	    findmnt -rno TARGET "$MNT" >/dev/null 2>&1
	}
	
	# If mounted → unmount
	if is_mounted; then
	    hyprctl dismissnotify && hyprctl notify -1 3000 $notify_color "fontsize:12 Locking encrypted videos"

	    sync
	    fusermount -uz "$MNT"

	    exit 0
	fi
	
	# Mount and let gocryptfs call zenity itself
	gocryptfs -ro -extpass="zenity --password --title=Unlock\ Videos\ Vault" "$ENC" "$MNT"
	
	if mount | grep -q "$MNT"; then
	    hyprctl dismissnotify && hyprctl notify -1 3000 $notify_color "fontsize:12 Videos unlocked"
	else
	    hyprctl dismissnotify && hyprctl notify -1 3000 $notify_color "fontsize:12 Failed to unlock"
	fi
      '';
  };
}

