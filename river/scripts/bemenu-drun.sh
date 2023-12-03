#!/usr/bin/env bash

if pidof bemenu > /dev/null 2>&1; then
    exit 0
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
    cmd="$(grep "^Exec=" "$app" | head -n1)"
    cmd="${cmd/Exec=/}"
    cmd="${cmd//%[cDdFfikmNnUuv]/}"
    echo "$name -- ${cmd}"

    if [ -z "$terminal" ] || [ "$terminal" = false ]; then
      desktop_apps["$name"]="$cmd"
    fi
  done
done

selection="$(for app in "${!desktop_apps[@]}"; do echo "$app"; done|bemenu)"
exec "$selection"
