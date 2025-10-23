#!/bin/sh
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Scripts for volume controls for audio and mic 

# Source Colors
colors="$HOME/.config/rofi/wallust/colors-rofi.rasi"

# Extract color3 value and make it bash-friendly
color3=$(grep -E 'color3:' "$colors" | sed -E 's/.*color3:\s*(#[0-9A-Fa-f]+);.*/\1/')


iDIR="$HOME/.config/swaync/icons"
sDIR="$HOME/.config/hypr/scripts"

# Send Notification
notification() {
    notify_color=${color3/#\#/}

    text1="$1"
    text2="$2"
    
    hyprctl dismissnotify && hyprctl notify -1 3000 "rgb($notify_color)" "fontsize:12 $text1 $text2"
}

# Get Volume
get_volume() {
    volume=$(pamixer --get-volume)
    if [[ "$volume" -eq "0" ]]; then
        echo "Muted"
    else
        echo "$volume %"
    fi
}

# Notify
notify_user() {
    if [[ "$(get_volume)" == "Muted" ]]; then
        notification "Volume:" "Muted"
    else
      notification "Volume Level:" "$(get_volume)" && "$sDIR/Sounds.sh" --volume
    fi
}

# Increase Volume
inc_volume() {
    if [ "$(pamixer --get-mute)" == "true" ]; then
        toggle_mute
    else
        pamixer -i 5 --allow-boost --set-limit 150 && notify_user
    fi
}

# Decrease Volume
dec_volume() {
    if [ "$(pamixer --get-mute)" == "true" ]; then
        toggle_mute
    else
        pamixer -d 5 && notify_user
    fi
}

# Toggle Mute
toggle_mute() {
	if [ "$(pamixer --get-mute)" == "false" ]; then
            pamixer -m && notification "Volume:" "Muted"
	elif [ "$(pamixer --get-mute)" == "true" ]; then
	    pamixer -u && notification "Volume:" "ON"
	fi
}

# Toggle Mic
toggle_mic() {
	if [ "$(pamixer --default-source --get-mute)" == "false" ]; then
		pamixer --default-source -m && notification "Microphone:" "Muted"

                #hyprctl dismissnotify && hyprctl notify 1 2000 "0xFFFFFF" "fontsize:10 Microphone: Muted"
	elif [ "$(pamixer --default-source --get-mute)" == "true" ]; then
		pamixer -u --default-source u && notification "Microphone:" "ON"

                #hyprctl dismissnotify && hyprctl notify 1 2000 "0xFFFFFF" "fontsize:10 Microphone: ON"
	fi
}

# Get Microphone Volume
get_mic_volume() {
    volume=$(pamixer --default-source --get-volume)
    if [[ "$volume" -eq "0" ]]; then
        echo "Muted"
    else
        echo "$volume %"
    fi
}

# Notify for Microphone
notify_mic_user() {
    volume=$(get_mic_volume)

    notification "Mic Level:" "$volume"
    #notify-send -e -h int:value:"$volume" -h "string:x-canonical-private-synchronous:volume_notif" -h boolean:SWAYNC_BYPASS_DND:true -u low -i "$icon"  " Mic Level:" " $volume"
}

# Increase MIC Volume
inc_mic_volume() {
    if [ "$(pamixer --default-source --get-mute)" == "true" ]; then
        toggle_mic
    else
        pamixer --default-source -i 5 && notify_mic_user
    fi
}

# Decrease MIC Volume
dec_mic_volume() {
    if [ "$(pamixer --default-source --get-mute)" == "true" ]; then
        toggle-mic
    else
        pamixer --default-source -d 5 && notify_mic_user
    fi
}

# Execute accordingly
if [[ "$1" == "--get" ]]; then
	get_volume
elif [[ "$1" == "--inc" ]]; then
	inc_volume
elif [[ "$1" == "--dec" ]]; then
	dec_volume
elif [[ "$1" == "--toggle" ]]; then
	toggle_mute
elif [[ "$1" == "--toggle-mic" ]]; then
	toggle_mic
elif [[ "$1" == "--mic-inc" ]]; then
	inc_mic_volume
elif [[ "$1" == "--mic-dec" ]]; then
	dec_mic_volume
else
	get_volume
fi
