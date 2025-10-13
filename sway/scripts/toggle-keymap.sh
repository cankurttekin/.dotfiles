#!/bin/bash

STATE_FILE="/tmp/xkb_toggle_state"
DEVICE_ID=$(swaymsg -t get_inputs | jq -r '.[] | select(.type == "keyboard") | .identifier' | head -n 1)

if [[ ! -f "$STATE_FILE" ]]; then
  echo "swap" > "$STATE_FILE"
  xkbcomp ~/.config/sway/xkb/swap.xkb $DISPLAY
else
  STATE=$(cat "$STATE_FILE")
  if [[ "$STATE" == "swap" ]]; then
    echo "default" > "$STATE_FILE"
    setxkbmap us 
  else
    echo "swap" > "$STATE_FILE"
    xkbcomp ~/.config/sway/xkb/swap.xkb $DISPLAY
  fi
fi
