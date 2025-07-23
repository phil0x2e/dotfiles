#!/usr/bin/env bash

selection="$(echo -e "poweroff\nreboot\nsoft-reboot" | fuzzel -d -p 'systemctl ' -l 3)" || exit 0
systemctl "$selection"
