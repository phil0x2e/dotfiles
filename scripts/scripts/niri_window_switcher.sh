#!/usr/bin/env bash

windows_out=$(niri msg windows)
# get the relevant data in tab separated form
window_information=$(echo "$windows_out" | grep -oP '(?<=^  Title: ").+(?=")|(?<=^  App ID: ").+(?=")|(?<=^Window ID )\d+(?=:)' | sed 's/\t/ /g' | paste - - - | awk -F '\t' 'BEGIN {OFS="\t"} {print $3,$2,$1}') || exit 1
echo "$window_information"

num_windows=$(echo "$window_information" | wc -l)
num_lines=$((num_windows < 15 ? num_windows : 15)) # maximum 15 lines, which is default line number for fuzzel

selection_window_id=$(echo "$window_information" | fuzzel -d -l "$num_lines" -w 64 --prompt " " --placeholder "Search for window to be focused" --accept-nth 3 --counter) || exit 1

niri msg action focus-window --id "$selection_window_id" || exit 2
