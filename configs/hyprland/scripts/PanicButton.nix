{config, pkgs, ... }:

{
  home.file.".config/hypr/scripts/PanicButton.sh" = {
	executable = true;
	text = builtins.replaceStrings ["__DOLLAR__"] ["$"] '' 
		#!/bin/sh
		
		# Function to generate a random start time (in seconds)
		function random_start_time {
		    # Generate a random number between 0 and 300 (5 minutes)
		    echo $(( RANDOM % 300 ))
		}
		
		# Close all web browsers and video players
		pkill -9 firefox
		pkill -9 thorium
		pkill -9 zen
		pkill -9 vlc
		pkill -9 mpv
		
		channels=(
		    "markiplier"
		    "gothamchess"
		    "kentuckyballistics"
		    "sortedfood"
		    "trevorbauer"
		    "watchmomentum"
		)
		
		#random_playlist=__DOLLAR__{playlists[RANDOM % __DOLLAR__{#playlists[@]}]}
		random_channel=__DOLLAR__{channels[RANDOM % __DOLLAR__{#channels[@]}]}
		
		# Download the playlist page and save it to curloutput.json
		curl -s "https://www.youtube.com/@$random_channel/videos" -o curloutput.json
		
		# Extract and store video IDs in an array
		video_IDs=($(grep -o '"videoId":"[^"]*' curloutput.json | sed 's/"videoId":"//;s/"//' | sort | uniq))
		
		# Randomly choose one video ID from the array
		random_video_id=__DOLLAR__{video_IDs[RANDOM % __DOLLAR__{#video_IDs[@]}]}
		
		# Generate random start time
		start_time=$(random_start_time)
		
		rm -rf curloutput.json # remove the curl output file as it is no longer needed
		
		nohup firefox "https://www.youtube.com/watch?v=$random_video_id&t=__DOLLAR__{start_time}s" >/dev/null 2>&1 &
		
		# Wait for Firefox to finish loading the webpage
		sleep 5  # Adjust sleep duration as needed
		
		# Send "SPACE" keyboard command using ydotool
		wtype -k i k # plays the video
		
		sleep 2 # added to support the below line to put the video in fullscreen
		
		wtype -k f # puts the video in fullscreen
		
		#Exit the program
		exit 0
		
	'';
  };
}
