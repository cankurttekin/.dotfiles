#!/bin/bash

current_orientation=""
current_tilt=""

monitor-sensor | while read -r line; do
    # Get accelerometer orientation
    if [[ $line =~ "Accelerometer orientation changed:" ]]; then
        orient=$(echo "$line" | awk '{print $NF}')
        [[ "$orient" == "$current_orientation" ]] && continue
        current_orientation="$orient"
    fi

    # Get tilt state
    if [[ $line =~ "Tilt changed:" ]]; then
        tilt=$(echo "$line" | awk '{print $NF}')
        [[ "$tilt" == "$current_tilt" ]] && continue
        current_tilt="$tilt"
    fi

    # Only rotate if tilt is vertical (ignore tent/face-down)
    if [[ "$current_tilt" == "vertical" ]]; then
        case "$current_orientation" in
            normal)
                swaymsg output eDP-1 transform normal
                ;;
            left-up)
                swaymsg output eDP-1 transform 270   # swap if it was opposite
                ;;
            right-up)
                swaymsg output eDP-1 transform 90    # swap if it was opposite
                ;;
            bottom-up)
                swaymsg output eDP-1 transform 180
                ;;
        esac
    fi

done
