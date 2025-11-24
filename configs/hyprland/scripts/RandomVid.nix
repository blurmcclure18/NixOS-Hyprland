{ config, pkgs, ... }:
{
  home.file.".config/hypr/scripts/RandomVid.sh" = {
	executable = true;
	text = 
	  builtins.replaceStrings ["__QUOTE__"] ["'"]
	    (builtins.replaceStrings ["__DOLLAR__"] ["$"]

	'' 
		#!/bin/sh
		
		# Define folders containing videos
		folders=(
		    "/home/alec/Videos/myvids/IRL/Belle"
		    "/home/alec/Videos/myvids/IRL/Sexy_B0rsch"
		    "/home/alec/Videos/myvids/IRL/Sia"
		    "/home/alec/Videos/myvids/IRL/Random Vids"
		    "/home/alec/Videos/myvids/E621"
		)
		
		# Find all video files within the folders
		videos=()
		for folder in "__DOLLAR__{folders[@]}"; do
		    while IFS= read -r -d __QUOTE__' file; do
		        videos+=("$file")
		    done < <(find "$folder" -type f \( -iname "*.mp4" -o -iname "*.mkv" -o -iname "*.avi" -o -iname "*.mov" -o -iname "*.webm" -o -iname "*.flv" \) -print0)
		done
		
		# Check if any videos were found
		if [ __DOLLAR__{#videos[@]} -eq 0 ]; then
		    echo "No videos found in the specified folders."
		    exit 1
		fi
		
		# Pick a random video
		random_video="__DOLLAR__{videos[RANDOM % __DOLLAR__{#videos[@]}]}"
		
		# Play the video with MPV
		mpv "$random_video"
	'');
  };
}
