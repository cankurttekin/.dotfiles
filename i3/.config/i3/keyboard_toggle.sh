#!/bin/bash

CUSTOM_KEYMAP="$HOME/.config/i3/swap.xkb"

# Temp file to track toggle state
STATE_FILE="/tmp/xkb_layout_toggled"

if [[ -f "$STATE_FILE" ]]; then
    # Revert to default layout
    setxkbmap -layout us
    rm "$STATE_FILE"
    echo "Default XKB Layout"
else
    # Load custom keymap
    xkbcomp "$CUSTOM_KEYMAP" $DISPLAY
    touch "$STATE_FILE"
    echo "Custom XKB layout applied"
fi

