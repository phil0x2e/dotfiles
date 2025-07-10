#!/usr/bin/env bash
input="$(fuzzel -d --placeholder='calc (e.g. 2*21)')" || exit 0
notify-send "$(echo "$input" | bc -l)"
