#!/bin/bash

#curl -s https://raw.githubusercontent.com/github/gemoji/master/db/emoji.json \
#  | jq -r '.[] | "\(.emoji) \(.description)"' > ~/.config/sway/scripts/emojis

emoji=$(cat ~/.config/sway/scripts/emoji | rofi -dmenu -i -p "Emoji")

echo -n "$emoji" | awk '{print $1}' | wl-copy
