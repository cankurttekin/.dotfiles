#!/bin/bash

# Path to store wallpaper
IMAGE_PATH="$HOME/.cache/sway_wallpaper.jpg"

# Generate random index (tune range based on known max)
RANDOM_INDEX=$((RANDOM % 3810))

# Fetch the response
RAW_RESPONSE=$(curl -s "https://www.wikiart.org/en/App/Home/ArtworkOfTheDay?direction=next&index=$RANDOM_INDEX")

# Step 1: Unwrap the escaped JSON string (remove quotes and unescape)
UNESCAPED_JSON=$(echo "$RAW_RESPONSE" | sed 's/^"//' | sed 's/"$//' | sed 's/\\"/"/g' | sed 's/\\r\\n/\n/g' | sed 's/\\u003c/</g' | sed 's/\\u003e/>/g')

# Step 2: Extract image URL
IMAGE_URL=$(echo "$UNESCAPED_JSON" | jq -r '.ImageDescription.Url')

# Validate image URL
if [[ "$IMAGE_URL" == null || -z "$IMAGE_URL" ]]; then
  echo "Failed to get image URL"
  echo "Response: $UNESCAPED_JSON"
  exit 1
fi

# Download the image
curl -s -L "$IMAGE_URL" -o "$IMAGE_PATH"

echo "IMAGE_URL: $IMAGE_URL"

# Kill existing swaybg instance
pkill swaybg

TITLE=$(echo "$UNESCAPED_JSON" | jq -r '.Title')
ARTIST=$(echo "$UNESCAPED_JSON" | jq -r '.ArtistName')
notify-send "Wallpaper: $TITLE" "by $ARTIST"

# Set wallpaper
swaybg -i "$IMAGE_PATH" -m fit
