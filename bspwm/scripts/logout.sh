LOCK=""
QUIT=""
SHUTDOWN=""
SUSPEND=""
HIBERNATE=""
RESTART=""

ACTION=$(echo -e "$LOCK
$QUIT
$SUSPEND
$HIBERNATE
$SHUTDOWN
$RESTART"|rofi -config "$HOME/.config/rofi/logout.rasi" -dmenu)

echo $ACTION

function lock() {
    betterlockscreen --lock
}

if [ "$ACTION" == "$QUIT" ]; then
    if [ ! -z $(pidof bspwm) ]; then
        bspc quit
    else
        echo "Fuck off...!!!"
    fi
elif [ "$ACTION" == "$LOCK" ]; then
    lock
elif [ "$ACTION" == "$SUSPEND" ]; then
    lock &
    systemctl suspend
elif [ "$ACTION" == "$HIBERNATE" ]; then
    lock &
    systemctl suspend-then-hibernate
elif [ "$ACTION" == "$RESTART" ]; then
    systemctl reboot
elif [ "$ACTION" == "$SHUTDOWN" ]; then
    systemctl poweroff
fi
