#!/usr/bin/env bash
order="$1"
workdir="$HOME/bin/statusbar"
flag='norm'

vpn_addr="$(ifconfig | grep -o 10\.8\.0\... | head -n 1)"
if [[ "$vpn_addr" == "" ]]; then
	vpn_addr="Down"
	flag='warn'
fi
text="$(printf '嬨 <span stretch="condensed" size="small">%s</span>' $vpn_addr)"

$workdir/markup.py "$order" "$flag" "$text"

