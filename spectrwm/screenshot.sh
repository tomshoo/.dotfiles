#!/bin/sh
#

screenshot() {
	case $1 in
	full)
		scrot 'screenshot_%Y%m%d_%H%M%S%T.png' -e 'mv $f ~/Pictures/ && xclip -selection clipboard -t image/png -i ~/Pictures`ls -1 -t ~/Pictures | head -1`' && notify-send Scrot 'Saved under /home/user/Pictures'
		;;
	window)
		sleep 1
		scrot -s 'screenshot_select_%Y%m%d_%H%M%S%T.png' -e 'mv $f ~/Pictures && xclip -selection clipboard -t image/png -i ~/Pictures `ls -1 -t ~/Pictures | head -1`'
		;;
	*)
		;;
	esac;
}

screenshot $1
