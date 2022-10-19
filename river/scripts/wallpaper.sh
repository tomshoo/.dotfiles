#!/bin/bash

WALLS_DIR=~/.local/share/backgrounds
readarray -d '' walls < <(find "$WALLS_DIR" -type f -print0)

bg_pid=$(pidof wbg)

echo $bg_pid
if [ ! -z "${bg_pid}" ]; then
    killall wbg
fi

len=$(for i in ${!walls[@]}; do
    echo ${walls[$1]}
done | wc -l)

wall=${walls[$(( $RANDOM % $len ))]}
wbg "$wall" &
cp "$wall" /tmp/current_wallpaper
