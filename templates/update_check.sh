#!/bin/bash

CACHE_DIR="$HOME/.cache/sva-sentinelone-update-check"
STATE_FILE="$CACHE_DIR/state-website.html"
BAK_FILE="$CACHE_DIR/state-website.html.bak"
FLAG_FILE="$CACHE_DIR/update-flag"

# Create cache directory if it doesn't exist
mkdir -p "$CACHE_DIR"

# Check if update-flag exists
if [ -f "$FLAG_FILE" ]; then
    notify-send "Update Sentinelone SVA" "An update is available. Remove the flag file: rm '$FLAG_FILE'"
    exit 0
fi

# If state file exists, move it to bak
if [ -f "$STATE_FILE" ]; then
    mv "$STATE_FILE" "$BAK_FILE"
fi

# Query the website and save output
curl -s {{ url }} -o "$STATE_FILE"

# If bak file exists, compare with new state file
if [ -f "$BAK_FILE" ]; then
    if ! cmp -s "$STATE_FILE" "$BAK_FILE"; then
        # Create the flag file
        touch "$FLAG_FILE"
        # They differ
        notify-send "Update Sentinelone SVA" "An update is available. Remove the flag file: rm '$FLAG_FILE'"
    fi
fi
