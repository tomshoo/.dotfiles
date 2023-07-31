#!/usr/bin/env bash

nopaging=false

if ! command -v fzf &> /dev/null; then
    echo 'error: fzf is not installed'
    exit 127
fi

case "$1" in
    -n|--nopaging) nopaging=true; shift ;;
    *) shift ;;
esac

[ -n "$1" ] && exit 0

options="$(curl https://cht.sh/:list)"
fzf_selection="$(echo "$options" | fzf)"

if [ -n "$fzf_selection" ]; then
    curl "https://cht.sh/$fzf_selection" 2> /dev/null |
        if "$nopaging"; then bat --plain --paging=never; else bat --plain; fi
fi

if "$nopaging"; then while (:;); do sleep 10; done; fi
