#!/bin/bash

while getopts d:i:m: flag; do
    case "${flag}" in
    d)  pactl set-sink-volume @DEFAULT_SINK@ "-${OPTARG}%"
        break
        ;;
    i)  pactl set-sink-volume @DEFAULT_SINK@ "+${OPTARG}%"
        break
        ;;
    m)  pactl set-sink-mute @DEFAULT_SINK@ toggle
        if [ "$(pamixer --get-volume-human)" == "muted" ]; then
            notify-send                                         \
                -h string:x-canonical-private-synchronous:audio \
                -a "com.desktop.River"                          \
                "Volume: "                                      \
                "$(pamixer --get-volume-human)"
            exit 0
        fi
        ;;
    *) ;;
    esac
done

percentage=$(pamixer --get-volume-human)
notify-send                                         \
    -h int:value:"${percentage}"                    \
    -h string:x-canonical-private-synchronous:audio \
    -a "com.desktop.River"                          \
    "Volume: ${percentage}"
