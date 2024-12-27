#!/bin/bash

# Pass the password in the block instance
. $HOME/.bash_mpd_vars

filter() {
    echo -n '['
    tr '\n' ' ' | grep -Po '.*(?= \[playing\])|paused' | tr -d '\n'
    echo -n ']'
}

case $BLOCK_BUTTON in
    1) mpc toggle | filter ;;  # right click, pause/unpause
    3) mpc toggle | filter ;;  # right click, pause/unpause
    4) mpc prev   | filter ;;  # scroll up, previous
    5) mpc next   | filter ;;  # scroll down, next
    *) mpc status | filter ;;
esac
