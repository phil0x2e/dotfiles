#!/bin/env bash

# output example:
# Picked color: rgb(30, 30, 46)
# Hex: #1e1e2e

pick_color_output=$(niri msg pick-color) || exit 1
hex_color=$(echo "$pick_color_output" | grep -oP '(?<=^Hex: )#\w{6}') || exit 1

notify-send "$pick_color_output" || exit 1

wl-copy "$hex_color" || exit 1
