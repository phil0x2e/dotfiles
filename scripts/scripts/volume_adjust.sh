#!/usr/bin/env bash
notification_path=/tmp/volume_adjust_notification_id
expire_time=750

if [[ "$1" == "toggle mute" ]]; then
  wpctl "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"
  if [[ "$(wpctl "get-volume" "@DEFAULT_AUDIO_SINK@")" == *"[MUTED]" ]]; then
    notify-send "  Audio muted" -t $expire_time
  else
    notify-send "  Audio unmuted" -t $expire_time
  fi
  exit 0
elif [[ "$1" == "toggle mute mic" ]]; then
  wpctl "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"
  if [[ "$(wpctl "get-volume" "@DEFAULT_AUDIO_SOURCE@")" == *"[MUTED]" ]]; then
    notify-send " Mic unmuted" -t $expire_time
  else
    notify-send "  Mic muted" -t $expire_time
  fi
  exit 0
fi

wpctl "set-volume" "@DEFAULT_AUDIO_SINK@" "$1"

volume="$(wpctl "get-volume" "@DEFAULT_AUDIO_SINK@" | sed "s/Volume: //")"
if [[ $volume == 0.* ]]; then
  percentage="${volume//0./}"
else
  percentage="${volume//./}"
fi

if [ -f "$notification_path" ]; then
  new_id="$(notify-send "" -h "int:value:$percentage" -t $expire_time -r "$(cat "$notification_path")" -p)"
  echo "$new_id" >"$notification_path"
else
  notify-send -p "" -h "int:value:$percentage" -t $expire_time >"$notification_path"
fi
