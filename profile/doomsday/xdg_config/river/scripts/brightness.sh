#!/bin/bash

while getopts d:i: flag; do
    case "${flag}" in
    i)  brightnessctl set "+${OPTARG}%"
        break
        ;;
    d)  brightnessctl set "${OPTARG}%-"
        break
        ;;
    *)  ;;
    esac
done

current=$(brightnessctl get)
max=$(brightnessctl max)
percent=$(awk "BEGIN { print (${current}/${max})*100 }")
notify-send \
    -h int:value:"$percent" \
    -h string:x-canonical-private-synchronous:light \
    -a "com.desktop.River" \
    "Brightness: $(echo "$percent" | cut -d. -f1)%"
