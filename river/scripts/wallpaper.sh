#!/bin/bash

WALLS_DIR=~/.local/share/backgrounds
readarray -d '' walls < <(find "$WALLS_DIR" -type f -print0)

wall=${walls[$(( RANDOM % ${#walls[@]} ))]}
swww img "$wall" --transition-type simple --transition-step 20 &
ffmpeg -i "$wall" /tmp/current_wallpaper.jpg -y
