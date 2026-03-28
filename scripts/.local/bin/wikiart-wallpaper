#!/usr/bin/env bash

set -euo pipefail

FONT="${FONT:-DejaVu-Sans}"
BG_COLOR="${BG_COLOR:-black}"

# Fetch artwork info
INDEX=$((RANDOM % 3810))
API_URL="https://www.wikiart.org/en/app/home/ArtworkOfTheDay?direction=next&index=$INDEX"
JSON=$(curl -sf "$API_URL") || { echo "Failed to fetch artwork info"; exit 1; }
UNESCAPED_JSON=$(echo "$JSON" | jq -r 'fromjson') || { echo "Failed to parse JSON"; exit 1; }

TITLE=$(echo "$UNESCAPED_JSON" | jq -r '.Title // empty')
ARTIST=$(echo "$UNESCAPED_JSON" | jq -r '.ArtistName // empty')
IMAGE_URL=$(echo "$UNESCAPED_JSON" | jq -r '.PaintingJson.image // empty')

if [[ -z "$TITLE" || -z "$ARTIST" || -z "$IMAGE_URL" ]]; then
    echo "Missing artwork data"
    exit 1
fi

# Download image to a temp file
IMAGE_PATH=$(mktemp /tmp/wikiart_wall.XXXXXX.jpg)
PROCESSED_IMAGE="$HOME/.cache/wikiart_wallpaper.jpg"
trap 'rm -f "$IMAGE_PATH"' EXIT

curl -sf -o "$IMAGE_PATH" "$IMAGE_URL" || { echo "Failed to download image"; exit 1; }

# Get current display resolution from Sway
read -r DISPLAY_WIDTH DISPLAY_HEIGHT <<< "$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | "\(.current_mode.width) \(.current_mode.height)"')"
if [[ -z "$DISPLAY_WIDTH" || -z "$DISPLAY_HEIGHT" ]]; then
    echo "Failed to get display resolution"
    exit 1
fi

# Create wallpaper with text, centered image, and black background
magick "$IMAGE_PATH" \
    -resize "x${DISPLAY_HEIGHT}" \
    -background "$BG_COLOR" \
    -gravity center \
    -extent "${DISPLAY_WIDTH}x${DISPLAY_HEIGHT}" \
    -gravity Southeast \
    -fill white \
    -undercolor '#00000080' \
    -font "$FONT" -pointsize 18 \
    -annotate +12+30 "$TITLE by $ARTIST" \
    "$PROCESSED_IMAGE" || { echo "ImageMagick processing failed"; exit 1; }

# Kill existing swaybg instances
pkill swaybg || true

# Start swaybg with the new wallpaper
swaybg -m fill -i "$PROCESSED_IMAGE" &
