#!/bin/bash

while getopts d:i:m: flag; do
    case "${flag}" in
    d) pactl set-sink-volume @DEFAULT_SINK@ "-${OPTARG}%"
       break ;;
    i) if ! [[ $(pamixer --get-volume) -ge 150 ]]; then
        pactl set-sink-volume @DEFAULT_SINK@ "+${OPTARG}%"
       fi
       break ;;
    m) pactl set-sink-mute @DEFAULT_SINK@ toggle
       break ;;
    *) ;;
    esac
done

p_arg=()
volume=$(pamixer --get-volume-human)

if ! [[ "$volume" = muted ]]; then
    p_arg=(-h int:value:"$volume")
fi

notify-send                                         \
    "${p_arg[@]}"                                   \
    -h string:x-canonical-private-synchronous:audio \
    -a "com.desktop.River"                          \
    "Volume: ${volume}"
