#!/bin/bash

# Fetch artwork info
INDEX=$((RANDOM % 3810))
API_URL="https://www.wikiart.org/en/app/home/ArtworkOfTheDay?direction=next&index=$INDEX"
JSON=$(curl -s "$API_URL")
UNESCAPED_JSON=$(echo "$JSON" | jq -r 'fromjson')

TITLE=$(echo "$UNESCAPED_JSON" | jq -r '.Title')
ARTIST=$(echo "$UNESCAPED_JSON" | jq -r '.ArtistName')
IMAGE_URL=$(echo "$UNESCAPED_JSON" | jq -r '.PaintingJson.image')

# Download image
IMAGE_PATH="/tmp/wikiart_wall.jpg"
PROCESSED_IMAGE="$HOME/.cache/wikiart_wallpaper_with_description.jpg"
curl -s -o "$IMAGE_PATH" "$IMAGE_URL"

# Get current display resolution from Sway
read DISPLAY_WIDTH DISPLAY_HEIGHT <<< $(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | "\(.current_mode.width) \(.current_mode.height)"')

# Create wallpaper with text, centered image, and black background
magick "$IMAGE_PATH" \
    -resize "x${DISPLAY_HEIGHT}" \
    -background black \
    -gravity center \
    -extent "${DISPLAY_WIDTH}x${DISPLAY_HEIGHT}" \
    -gravity Southeast \
    -fill white \
    -undercolor '#00000080' \
    -font "DejaVu-Sans" -pointsize 18 \
    -annotate +12+30 "$TITLE by $ARTIST" \
    "$PROCESSED_IMAGE"

# Kill existing swaybg instances
pkill swaybg

# Start swaybg with the new wallpaper
swaybg -m fill -i "$PROCESSED_IMAGE" &
