#!/usr/bin/env bash

outputs=$(niri msg outputs | grep -oP '(?<=Output ").+(?=")') || exit 0
selected_output=$(echo "$outputs" | fuzzel -d --placeholder="Select output") || exit 0
selected_action=$(echo -e "on\noff" | fuzzel -d --placeholder="Turn output on/off") || exit 0

niri msg output "$selected_output" "$selected_action"
