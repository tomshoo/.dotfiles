#! /bin/sh

if [ "$1" == "volume" ]; then
	if [ "$2" == "down" ]; then
		pactl set-sink-volume @DEFAULT_SINK@ -5%
	elif [ "$2" == "up" ]; then
		pactl set-sink-volume @DEFAULT_SINK@ +5%
	elif [ "$2" == "mute" ]; then
		pactl set-sink-mute @DEFAULT_SINK@ toggle
	else
		echo "Invalid syntax"
	fi
elif [ "$1" == "light" ]; then
	if [ "$2" == "down" ]; then
		light -U 5
	elif [ "$2" == "up" ]; then
		light -A 5
	else
		echo "Invalid syntax"
	fi
fi