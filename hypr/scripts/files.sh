#!/usr/bin/env sh

if pidof thunar; then
     hyprctl dispatch togglespecialworkspace files
else thunar
fi
