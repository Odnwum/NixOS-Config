#!/usr/bin/env bash

brightness=$(brightnessctl get)
max_brightness=$(brightnessctl max)
percent=$((brightness * 100 / max_brightness))

# Determine number of filled blocks
if (( percent < 4 )); then
  filled_blocks=0
else
  filled_blocks=$((percent / 10))
  if (( filled_blocks == 0 )); then
    filled_blocks=1
  fi
fi

empty_blocks=$((10 - filled_blocks))

# Build the bar
bar="["
if (( filled_blocks > 0 )); then
  bar+=$(printf '█%.0s' $(seq 1 $filled_blocks))
fi
if (( empty_blocks > 0 )); then
  bar+=$(printf '░%.0s' $(seq 1 $empty_blocks))
fi
bar+="]"

# Choose color
if (( percent < 30 )); then
  color="#FF5555"
elif (( percent < 70 )); then
  color="#F1C40F"
else
  color="#55FF55"
fi

# Output to Waybar (only valid JSON)
echo "{\"text\": \"BRI: $percent% $bar\", \"class\": \"brightness\", \"color\": \"$color\"}"

