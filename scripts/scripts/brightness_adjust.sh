#!/usr/bin/env bash
notification_path=/tmp/brightness_adjust_notification_id

brightnessctl s "$1"

max="$(brightnessctl m)"
cur="$(brightnessctl g)"
percentage=$((cur * 100 / max))

if [ -f "$notification_path" ]; then
  new_id="$(notify-send "󰃠" -h "int:value:$percentage" -t 500 -r "$(cat "$notification_path")" -p)"
  echo "$new_id" >"$notification_path"
else
  notify-send -p "󰃠" -h "int:value:$percentage" -t 500 >"$notification_path"
fi
