#!/bin/bash

# get focused output name
OUTPUT=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused == true) | .name')

# get the current transform value
CURRENT=$(swaymsg -t get_outputs | jq -r ".[] | select(.name==\"$OUTPUT\") | .transform")

# determine next rotation
case "$CURRENT" in
  "normal") NEXT="90" ;;
  "90") NEXT="180" ;;
  "180") NEXT="270" ;;
  "270") NEXT="normal" ;;
  *) NEXT="normal" ;;
esac

swaymsg output "$OUTPUT" transform "$NEXT"
