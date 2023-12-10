#!/bin/bash

waybar_pid=$(pidof waybar)

for pid in ${waybar_pid}; do
    kill "$pid"
done

waybar --config ~/.config/waybar/config.jsonc --style ~/.config/waybar/style.css
