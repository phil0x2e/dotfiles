#!/bin/env bash

# output example:
# Picked color: rgb(30, 30, 46)
# Hex: #1e1e2e

pick_color_output=$(niri msg pick-color) || exit 1
hex_color=$(echo "$pick_color_output" | grep -oP '(?<=^Hex: )#\w{6}') || exit 1

notify-send 'Color picked' "$pick_color_output <span color=\"$hex_color\">██</span>" || exit 1

wl-copy "$hex_color" || exit 1

sleep 0.25
notify-send -t 1250 "Copied Hex color to clipboard"
