#!/bin/bash
ARGS=$(getopt -a --options sc --long "screen,clipboard" == "$@")

eval set -- "$ARGS"

SCREEN=0
CLIPBOARD=0

while true; do
    case "$1" in
        -s|--screen)
            SCREEN=1
            shift 1
            ;;
        -c|--clipboard)
            CLIPBOARD=1
            shift 1
            ;;
        --) break ;;
    esac
done

GEOMETRY=""
CLIPCMD=""

[ ! $SCREEN -eq 0 ] && GEOMETRY='-g "$(slurp)"'
[ ! $CLIPBOARD -eq 0 ] && CLIPCMD="- | wl-copy -t image/png"

bash -c "grim -t png $GEOMETRY $CLIPCMD"

if [ $CLIPBOARD -eq 0 ]; then
    dunstify -a Grim "New Screenshot" "Screenshot saved to ~/Pictures"
else
    dunstify -a Grim "New Screenshot" "Screenshot copied to clipboard"
fi
