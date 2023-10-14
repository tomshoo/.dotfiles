#!/usr/bin/env bash

if ! pidof swww-daemon; then
    swww init
    image=$(swww query | cut -d' ' -f8)
    [[ -n "$image" ]] && ffmpeg -i "$image" /tmp/current_wallpaper.jpg -y
    exit 0;
fi

wall="$1"

if [ -z "$wall" ]; then
    WALLS_DIR=~/.local/share/backgrounds
    readarray -d '' walls < <(find "$WALLS_DIR" -type f -print0)

    wall=${walls[$(( RANDOM % ${#walls[@]} ))]}
fi

swww img "$wall" --transition-type simple --transition-step 20 &
ffmpeg -i "$wall" /tmp/current_wallpaper.jpg -y
