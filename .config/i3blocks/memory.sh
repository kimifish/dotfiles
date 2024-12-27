#!/usr/bin/env bash
order="$1"
workdir="$HOME/bin/statusbar"
flag='norm'

t_crit=1
t_warn=2

text=$(awk '/^MemAvailable:/ {mem_free+=$2} END {printf("%.1f", mem_free/1024/1024)}' /proc/meminfo)
#text="<span size='small' stretch='condensed'>mem:</span>$text"

if python3 -c "import sys; result = 0 if float($text) < float($t_crit) else 1; sys.exit(result)"; then   
	flag='crit'
elif python3 -c "import sys; result = 0 if float($text) < float($t_warn) else 1; sys.exit(result)"; then   
	flag='warn'
fi
text=" $text"G

$workdir/markup.py "$order" "$flag" "$text"
