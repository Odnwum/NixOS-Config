#!/usr/bin/env bash

# Get volume and mute status
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -1 | tr -d '%')
muted=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -o 'yes')

# Bar setup
filled_blocks=$((volume / 10))        # 0 to 5
empty_blocks=$((10 - filled_blocks))   # Fill out the rest

# Use unicode block characters
bar="["
bar+=$(printf '█%.0s' $(seq 1 $filled_blocks))
bar+=$(printf '░%.0s' $(seq 1 $empty_blocks))
bar+="]"

# Choose color
if [[ $muted == "yes" ]]; then
  echo '{"text": "VOL: [MUTE]", "class": "mute", "tooltip": "Muted"}'
  exit
elif (( volume == 0 )); then 
  echo '{"text": "VOL: [MUTE]", "class": "mute", "tooltip": "Muted"}'
  exit
elif (( volume < 30 )); then
  color="#FF5555"
elif (( volume < 70 )); then
  color="#F1C40F"
else
  color="#55FF55"
fi

# Output JSON
echo "{\"text\": \"VOL: $volume% $bar \", \"class\": \"volume\", \"color\": \"$color\"}"

