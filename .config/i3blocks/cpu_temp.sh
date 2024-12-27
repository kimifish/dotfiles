#!/usr/bin/env bash
order="$1"
workdir="$HOME/bin/statusbar"
flag='norm'

raw_temp=$(sensors | grep "Package" | awk '{print $4}')
temp=${raw_temp:1}
temp="${temp%.0°C}"
if [[ $temp -gt 84 ]]; then
	flag='crit'
fi
text="$(printf ' %s°' $temp)"
$workdir/markup.py "$order" "$flag" "$text"
