#!/bin/bash

if ! command -v notify-send &> /dev/null; then
    echo "notification thing is not installed"
    exit 0
fi

volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%')
muted=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

if [ "$muted" == "yes" ]; then
    volume="Muted"
    percentage=0
else
    max_volume=120
    percentage=$((volume * 100 / max_volume))
fi

notify-send \
    -a sway \
    -h string:x-canonical-private-synchronous:volume \
    -h "int:value:$percentage" \
    -e \
    -t 800 \
    "[volume: $volume]"
