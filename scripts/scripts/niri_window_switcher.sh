#!/usr/bin/env bash

for prog in niri jq; do
  command -v "$prog" >/dev/null 2>&1 || {
    echo "Error: $prog is not installed."
    exit 1
  }
done

windows_json=$(niri msg -j windows) || exit 2

num_windows=$(echo "$windows_json" | jq '. | length') || exit 3
num_lines=$((num_windows < 15 ? num_windows : 15)) # maximum 15 lines, which is default line number for fuzzel

formatted_windows=$(echo "$windows_json" | jq -r '.[] | "\(.app_id)\t\(.title)\t\(.id)"') || exit 4
selection_window_id=$(echo "$formatted_windows" | fuzzel -d -l "$num_lines" -w 64 --prompt " " --placeholder "Search for window to be focused" --accept-nth 3 --counter --tab 4) || exit 0

niri msg action focus-window --id "$selection_window_id" || exit 5
