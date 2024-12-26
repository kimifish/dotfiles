# xset -dpms # Disables Energy Star features
# xset s off # Disables screen saver
setxkbmap -layout kimi,ru -variant latin, -option grp:caps_toggle -option grp_led:scroll -option lv5:ralt_switch -option lv3:menu_switch
set r rate 280 40
/home/kimifish/.config/screenlayout/kimipc.sh
#. /home/kimifish/.bashrc.d/palettes
exec i3
