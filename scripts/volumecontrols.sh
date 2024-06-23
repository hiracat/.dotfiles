#!/bin/sh

MAX_VOLUME=150

# Get the current volume
current_volume=$(pactl list sinks | grep 'Volume: front-left' | awk '{print $5}' | sed 's/%//')

# Calculate the new volume level based on the scroll direction
new_volume=$((current_volume + $1))

# Cap the volume at the maximum threshold
if [ $new_volume -gt $MAX_VOLUME ]; then
    new_volume=$MAX_VOLUME
fi

if [ $new_volume -lt 0 ]; then
    new_volume=0
fi

# Set the new volume level
amixer sset 'Master' "${new_volume}%"
