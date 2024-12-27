#!/bin/bash
order="$1"
workdir="$HOME/bin/statusbar"
flag='norm'

INTERFACE="${BLOCK_INSTANCE:-wlan0}"
#echo $BLOCK_INSTANCE
#echo $INTERFACE

[[ ! -d /sys/class/net/${INTERFACE}/wireless ]] ||
    [[ "$(cat /sys/class/net/$INTERFACE/operstate)" = 'down' ]] && exit

#------------------------------------------------------------------------

QUALITY=$(grep $INTERFACE /proc/net/wireless | awk '{ print int($3 * 100 / 70) }')

#------------------------------------------------------------------------

# color
if [[ $QUALITY -lt 60 ]]; then
	flag='warn'
elif [[ $QUALITY -lt 40 ]]; then
	flag='crit'
fi
QUALITY="$QUALITY%"
text="直 $(printf '%-4s' $QUALITY)"

$workdir/markup.py "$order" "$flag" "$text"
