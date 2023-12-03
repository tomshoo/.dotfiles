#!/usr/bin/env bash

set-wallpaper() {
    wallpaper_file="$1"

    swww img "$wallpaper_file" --transition-type simple --transition-step 20 &

    [[ -f /tmp/current_wallpaper.jpg ]] && mv /tmp/current_wallpaper.jpg /tmp/current_wallpaper.jpg.backup

    if ffmpeg -i "$wallpaper_file" /tmp/current_wallpaper.jpg; then
        [[ -f /tmp/current_wallpaper.jpg.backup ]] && rm /tmp/current_wallpaper.jpg.backup
    else
        [[ -f /tmp/current_wallpaper.jpg.backup ]] && mv /tmp/current_wallpaper.jpg.backup /tmp/current_wallpaper.jpg
    fi
}

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
