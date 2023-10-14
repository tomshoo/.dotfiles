#!/usr/bin/env bash

if bemenu_pids="$(pidof bemenu)"; then
    for pid in $bemenu_pids; do kill -9 "$pid"; done
fi

typeset -A desktop_apps
desktop_apps=()

search_paths=(
  /usr/share/applications
  /var/lib/flatpak/exports/share/applications
  "$HOME/.local/share/applications"
)

for search_path in "${search_paths[@]}"; do
  [ -z "$(ls -A "$search_path")" ] && continue

  for app in "$search_path"/*.desktop; do
    name=$(basename "${app/.desktop/}")
    terminal="$(grep "^Terminal=" "$app")"
    terminal="${terminal#Terminal=}"

    if [ -z "$terminal" ] || [ "$terminal" = false ]; then
      desktop_apps["$name"]="$app"
    fi
  done
done

selection="$(for app in "${!desktop_apps[@]}"; do echo "$app"; done|bemenu)"
[ -z "$selection" ] && exit 0

dfile="${desktop_apps["$selection"]}"

awk                                                                                 \
    '/^Exec=/ {sub("^Exec=", ""); gsub(" ?%[cDdFfikmNnUuv]", ""); exit system($0)}' \
    "$dfile"
