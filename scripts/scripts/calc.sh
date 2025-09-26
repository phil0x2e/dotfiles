#!/usr/bin/env bash
input="$(fuzzel -d -p ' > ' --placeholder='e.g. 6*7' -l 0)" || exit 0
notify-send " " "$(echo "$input" | bc -l)"
