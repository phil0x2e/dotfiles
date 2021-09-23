#!/bin/bash
# Return number of windows on specific monitor, if monocle mode is active
monitor=$1

active_ws=$(bspc query -D -d .active -m $monitor)
num_ws=$(bspc query -N -d $active_ws | grep -f <(bspc query -N -n .leaf) | wc -l)

mode=$(bspc query -T -d $active_ws | jq -r .layout)
if [[ $mode == "monocle" && $num_ws > 1 ]]
then
    echo $num_ws
    exit 0
fi
exit 1
