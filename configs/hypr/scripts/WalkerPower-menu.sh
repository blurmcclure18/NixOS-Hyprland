#!/bin/sh

items="Shutdown\nReboot\nLock\nSuspend"

output=$(echo -e $items | walker --dmenu --theme dmenu_250)

if [[ "$output" == "Shutdown" ]]; then
    echo "Execute shutdown command"
    shutdown now
elif [[ "$output" == "Reboot" ]]; then
    echo "Execute reboot command"
    reboot
elif [[ "$output" == "Lock" ]]; then
    echo "Execute lock command"
    hyprlock
elif [[ "$output" == "Suspend" ]]; then
    echo "Execute suspend command"
    systemctl suspend
else
    echo "Please select a command"
fi
