#!/usr/bin/env bash
order="$1"
workdir="$HOME/bin/statusbar"
flag='norm'

text=$(/usr/share/i3blocks/bandwidth)

$workdir/markup.py "$order" "$flag" "$text"

