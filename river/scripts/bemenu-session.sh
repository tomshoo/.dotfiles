#!/usr/bin/env bash

if bemenu_pids="$(pidof bemenu)"; then
    for pid in $bemenu_pids; do kill -9 "$pid"; done
fi

actions=(
    lock
    hibernate
    suspend
    shutdown
    restart
)

action="$(echo "${actions[@]}" | tr ' ' '\n' | bemenu)"

lock() {
    if [[ -r /tmp/current_wallpaper.jpg ]]; then
         swaylock -i /tmp/current_wallpaper.jpg
    else swaylock -c 000000
    fi
}

case "$action" in
lock)      lock                                    ;;
hibernate) lock & systemctl suspend-then-hibernate ;;
suspend)   lock & systemctl suspend                ;;
shutdown)  poweroff                                ;;
restart)   reboot                                  ;;
esac
