#!/usr/bin/env bash

OPTIONS="󰐥 Power Off\n󰑓 Reboot\n󰤄 Sleep\n󰗼 Exit\n󰅖 Cancel"

CHOSEN=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "System:" -theme-str 'window {width: 25%;}')

case "$CHOSEN" in
    *Power*)
        systemctl poweroff
        ;;
    *Reboot*)
        systemctl reboot
        ;;
    *Sleep*)
        systemctl suspend
        ;;
    *Exit*)
        hyprctl dispatch exit
        ;;
    *)
        exit 0
        ;;
esac
