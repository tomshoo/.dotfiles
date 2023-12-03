#!/bin/bash

waybar_pid=$(pidof waybar)

for pid in ${waybar_pid}; do
    kill "$pid"
done

waybar --config ~/.config/hypr/waybar/config.jsonc --style ~/.config/hypr/waybar/style.css
