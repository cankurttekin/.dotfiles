#!/bin/bash

history_limit=20
history_file=~/.local/share/clipboard_history

# Get the current clipboard content
current_clipboard=$(wl-paste)

# If clipboard is not empty and not already in the history, add it
if [ -n "$current_clipboard" ] && ! grep -Fxq "$current_clipboard" "$history_file"; then
    # Add new clipboard content to history
    echo "$current_clipboard" >> "$history_file"
fi

# Limit clipboard history to the last $history_limit entries
tail -n $history_limit "$history_file" > "$history_file.tmp" && mv "$history_file.tmp" "$history_file"

# Show clipboard history in Rofi (most recent entry is at the top)
chosen=$(tac "$history_file" | rofi -dmenu -p "Clipboard")

# If something is chosen, copy it back to clipboard
if [ ! -z "$chosen" ]; then
    echo -n "$chosen" | wl-copy
fi
