#! /bin/sh

lxqt-policykit-agent &

print_bat() {
	if [ -f /sys/class/power_supply/BAT0/status ]; then
		BAT_STATUS=$(cat /sys/class/power_supply/BAT0/status)
		BAT_CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)
		echo " BAT: ${BAT_CAPACITY}  STAT: ${BAT_STATUS} "
		if [ "$BAT_CAPACITY" -lt "10" ] && [ "$BAT_STATUS" != "Charging" ]; then
			notify-send "Warning: Battery low" "Less than 10% battery remainig, pease connect to a power source"
		elif ! [ -z "$(ps -aux| grep notify-osd | awk 'NR==2')"]; then
		   killall -a notify-osd
		fi
	else
		echo STAT: AC_SUPPLY
	fi
}

print_wifi() {
	 WIFI_STATUS=$(nmcli -t -f active,ssid dev wifi | egrep '^yes' | cut -d\' -f2|cut -c 5-)
	 if [ -z "$WIFI_STATUS" ]; then
	 	printf "W: down | "
	 else
	 	printf "W:  $WIFI_STATUS | "
	 fi
}

print_hdd(){
	used=$(df -h|awk 'NR==4{print $3, $5}')
	printf 'Used: %s | ' "${used}"
}

print_vol() {
	VOLUME_LVL=$(pamixer --get-volume-human)
	printf 'VOL: %s | ' "${VOLUME_LVL}"
}

while :; do
	print_bat
	print_hdd
	print_vol
	print_wifi
	sleep 1
done
