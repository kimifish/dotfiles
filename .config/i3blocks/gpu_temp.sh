#!/bin/bash
if [[ -v BLOCK_BUTTON ]]; then
    case "$BLOCK_BUTTON" in
    	1) i3-msg exec 'gnome-terminal -e "watch -n 2 nvidia-smi" --role="htop"' ;;
	#*) ;;
    esac
fi
RED='\033[1;31m'
raw_temp=$(nvidia-smi | head -n 9 | tail -n 1 | awk '{print $3'} | cut -d "C" -f 1 -)
temp=${raw_temp:-1}
#temp="${temp%.0°C}"
echo "$temp°"
echo "$temp°"
if [[ $temp -gt 84 ]]; then
    if [[ $temp -gt 100 ]]; then
	echo "#FF0000"
    else
	echo "#FFFC00"
    fi
else
    echo "#C1C1C1"
fi
