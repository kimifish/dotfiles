#!/bin/bash

if [[ "$1" == "start" ]]; then
	DISPLAY=:0 xautolock 
		#-time 14 \
		#-killtime 15 \
		#-corners 0-0+ \
		#-cornerdelay 3 \
		#-cornerredelay 60 \
		#-detectsleep \
		#-locker "/home/kimifish/.config/i3/autolock lock" \
		#-killer "xset dpms force off" 
#	exit 0
fi

if [[ "$1" == "toggle" ]]; then
	if [[ "$AUTOLOCK_SCREEN" == "on" ]]; then
		export AUTOLOCK_SCREEN=off
		echo "Autolock is now off."
		notify-send "Autolock is OFF"
		exit 0
	else
		export AUTOLOCK_SCREEN=on
		echo "Autolock is now on."
		notify-send "Autolock is ON"
	fi
	exit 0
fi

#if [[ "$AUTOLOCK_SCREEN" == "on" ]]; then
	#[[ "$(xkb-switch -p)" == "ru" ]] && xkb-switch -n
	#screenlock $1
	##i3lock -nf --color=000000
#fi

