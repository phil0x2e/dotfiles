#!/usr/bin/env bash

outputs=$(niri msg outputs | grep -oP '(?<=Output ").+(?=")') || exit 0
selected_output=$(echo "$outputs" | fuzzel -d -p '󰍺 > ' --placeholder="Select output") || exit 0
selected_action=$(echo -e "󰍹 on\n󰶐 off" | fuzzel -d -p ' > ' --placeholder="Turn output on/off" | sed 's/^.* //') || exit 0

niri msg output "$selected_output" "$selected_action"
