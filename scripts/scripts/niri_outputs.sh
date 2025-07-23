#!/usr/bin/env bash

outputs=$(niri msg outputs | grep -oP '(?<=Output ").+(?=")') || exit 0
num_outputs=$(echo "$outputs" | wc -l)
num_lines=$((num_outputs < 15 ? num_outputs : 15)) # maximum 15 lines, which is default line number for fuzzel
selected_output=$(echo "$outputs" | fuzzel -d -p '󰍺 > ' --placeholder="Select output" -l "$num_lines") || exit 0
selected_action=$(echo -e "󰍹 on\n󰶐 off" | fuzzel -d -p ' > ' --placeholder="Turn output on/off" -l 2 | sed 's/^.* //') || exit 0

niri msg output "$selected_output" "$selected_action"
