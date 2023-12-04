#!/usr/bin/env bash

if pidof bemenu > /dev/null 2>&1; then
    exit 0
fi

TERMINAL="${TERMINAL:-kitty}"

typeset -A desktop_apps term_open
desktop_apps=()
term_open=()

search_paths=()
if [[ -n "$XDG_DATA_DIRS" ]]; then
    # shellcheck disable=SC2086
    for data_dir in $(IFS=:; echo $XDG_DATA_DIRS);
    do [[ -d "$data_dir/applications" ]] && search_paths+=("$data_dir/applications"); done
else
    search_paths+=(
      /usr/share/applications
      /var/lib/flatpak/exports/share/applications
      "$HOME/.local/share/applications"
    )
fi


for search_path in "${search_paths[@]}"; do
    applicationfiles=$(find "$search_path" -name '*.desktop' -printf '%p:')
    # shellcheck disable=SC2086
    for app in $(IFS=:; echo $applicationfiles); do
        [[ -z "$app" ]] && continue

        terminal="$(grep '^Terminal=' "$app")"
        terminal="${terminal#Terminal=}"

        [[ -z "$terminal" ]] && terminal=false

        cmd="$(grep '^Exec=' "$app" | head -n1)"
        cmd="$(sed -e 's/^Exec=//g ; s/%[cDdFfikmNnUuv]//g' <<< ${cmd})"

        [[ -z "$cmd" ]] && continue

        appname="$(basename "${app/.desktop/}")"

        echo "$appname -- $cmd"
        desktop_apps["$appname"]="$cmd"
        term_open["$appname"]="$terminal"
    done
done

selection="$(for app in "${!desktop_apps[@]}"; do echo "$app"; done|bemenu)"
[[ -z "$selection" ]] && exit 0

echo "${term_open["$selection"]} -- ${desktop_apps["$selection"]} "

if [[ "${term_open["$selection"]}" = true ]]; then
    exec "$TERMINAL" -- bash -c "${desktop_apps["$selection"]}"
else
    exec bash -c "${desktop_apps[$selection]}"
fi
