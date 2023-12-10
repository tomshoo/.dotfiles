#!/usr/bin/env bash

clients="$(hyprctl clients -j | jq '.[] | select(.class == "terminal.Scratchpad")')"

if [[ -z "$clients" ]]; then
    exec kitty --class=terminal.Scratchpad
else
    hyprctl dispatch togglespecialworkspace terminal
fi
