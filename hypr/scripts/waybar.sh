#!/bin/bash

waybar_pid=$(pidof waybar)

for pid in ${waybar_pid}; do
    kill -SIGKILL $pid
done

waybar --config $HOME/.config/hypr/waybar/config --style $HOME/.config/hypr/waybar/style.css
