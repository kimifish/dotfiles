#!/usr/bin/env bash
order="$1"
flag='norm'
workdir="$HOME/bin/statusbar"

export CURRENT_LAYOUT=$(xkblayout-state print "%n")


text="Xx"
if [[ "$CURRENT_LAYOUT" == "English" ]]; then 
	text="En"
elif [[ "$CURRENT_LAYOUT" == "Russian" ]]; then 
	text="Ru"
	flag='crit'
fi

$workdir/markup.py "$order" "$flag" "$text"

