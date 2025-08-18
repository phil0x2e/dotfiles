#!/usr/bin/env bash

for prog in niri jq; do
  command -v "$prog" >/dev/null 2>&1 || {
    echo "Error: $prog is not installed."
    exit 1
  }
done

outputs_json=$(niri msg -j outputs) || exit 2

num_outputs=$(echo "$outputs_json" | jq '. | length') || exit 3
num_lines=$((num_outputs < 15 ? num_outputs : 15)) # maximum 15 lines, which is default line number for fuzzel

formatted_outputs=$(echo "$outputs_json" | jq -r '.[] | "\(.make)\t\(.model)\t\(.name)"') || exit 4
selected_output=$(echo "$formatted_outputs" | fuzzel -d -p '󰍺 > ' --placeholder="Select output" -l "$num_lines" --accept-nth 3 --tabs 2 -w 45) || exit 0

selected_action=$(echo -e "󰍹 on\n󰶐 off" | fuzzel -d -p ' > ' --placeholder="Turn output on/off" -l 2 | sed 's/^.* //') || exit 5

niri msg output "$selected_output" "$selected_action" || exit 6

killall kanshi && notify-send 'Killed kanshi, to not overwrite output configuration.'
