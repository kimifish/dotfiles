#!/usr/bin/env bash
order=$1
flag='norm'
workdir="$HOME/bin/statusbar"
text=$(date "+%d.%m.%Y %a %T")

#$workdir/pango_markup.sh "$date_text" "$ccol" "$pcol" "$fgcol"
$workdir/markup.py "$1" "$flag" "$text"
