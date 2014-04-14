#!/usr/bin/env zsh

alarmClock() {
	if (( $# < 2 || $# > 2)); then
		echo "alarmClock <HH:MM, 24hr> <file, mplayer-compat.>"
		return
	fi

	while [ ! "$(date +%H:%M)" = "$1" ];
	do
	    sleep 5
	done

#	ponymix set-volume $3
	mplayer "$2"
}

