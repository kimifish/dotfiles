# ~/.profile: executed by the command interpreter for login shells.
#echo "========== Entering .profile ==========" 
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.
# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022
export LANG=ru_RU.UTF-8
export LC_CTYPE=ru_RU.UTF-8
export LC_ALL=ru_RU.UTF-8

# Change keyboard repeat and delay
xset r rate 280 40

XDG_DATA_HOME="$HOME/.local/share"
XDG_CONFIG_HOME="$HOME/.config"
XDG_CONFIG_DIR="$HOME/.config"
XDG_STATE_HOME="$HOME/.local/state"
XDG_CACHE_HOME="$HOME/.cache"
PATH="/usr/local/sbin::/usr/sbin:/sbin/:/bin:/usr/bin"

# set PATH so it includes user's private bin if it exists
if [ -d "/usr/lib/lightdm/lightdm" ] ; then
    PATH="/usr/lib/lightdm/lightdm:$PATH"
fi
if [ -d "/usr/games" ] ; then
    PATH="/usr/games:$PATH"
fi
if [ -d "/snap/bin" ] ; then
	PATH="/snap/bin:$PATH"
fi
if [ -d "/usr/local/games" ] ; then
    PATH="/usr/local/games:$PATH"
fi
if [ -d "/usr/local/bin" ] ; then
    PATH="/usr/local/bin:$PATH"
fi
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/kimiside@gmail.com/bin" ] ; then
    PATH="$HOME/kimiside@gmail.com/bin:$PATH"
fi
if [ -d "$HOME/bin/Java" ] ; then
	PATH="$HOME/bin/Java:$PATH"
fi
if [ -d "$HOME/bin/kimibot" ] ; then
	PATH="$HOME/bin/kimibot:$PATH"
fi
if [ -d "$HOME/.local/bin" ] ; then
	PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "$HOME/.local/go/bin" ] ; then 
	PATH="$HOME/.local/go/bin:$PATH"
fi
if [ -d "/usr/local/go" ] ; then 
	PATH="/usr/local/go:$PATH"
fi
if [ -d "/opt/amdgpu/bin" ] ; then 
	PATH="/opt/amdgpu/bin:$PATH"
fi
if [ -d "/opt/amdgpu-pro/bin" ] ; then 
	PATH="/opt/amdgpu-pro/bin:$PATH"
fi
if [ -d "/home/kimifish/.local/share/cargo/bin" ] ; then 
	PATH="/home/kimifish/.local/share/cargo/bin:$PATH"
fi

# Added by Toolbox App
export PATH="$PATH:/home/kimifish/.local/share/JetBrains/Toolbox/scripts"

# Detecting current window manager if X server is running
#if xset q &>/dev/null; then
    #export ACTIVE_WM=$(wmctrl -m | grep "^Name: .*$" | awk '{ print $2 }')
#else
    #export ACTIVE_WM=""
#fi
export AUTOLOCK_SCREEN="on"
export QT_QPA_PLATFORMTHEME="qt5ct"

# Exporting some DBus variables if DBus itself didn't do this
export $(dbus-launch)

[[ -f ${HOME}/.bashrc.d/palettes ]] && . "$HOME/.bashrc.d/palettes"
[[ -f ${HOME}/.bashrc.d/mpd_vars ]] && . "$HOME/.bashrc.d/mpd_vars"
[[ -f ${HOME}/.bashrc.d/phone_vars ]] && . "$HOME/.bashrc.d/phone_vars"
[[ -f ${HOME}/.bashrc.d/kimibot_vars ]] && . "$HOME/.bashrc.d/kimibot_vars"

[[ -f /usr/bin/terminology ]] && export TERMINAL="terminology"
[[ -f /$HOME/.local/bin/kitty ]] && export TERMINAL="kitty"
[[ -f /bin/kitty ]] && export TERMINAL="kitty"

[ -d "$HOME/.config/zsh" ] && export ZDOTDIR="$HOME/.config/zsh"
export ANDROID_HOME="$XDG_DATA_HOME"/android
export ATOM_HOME="$XDG_DATA_HOME"/atom
export HISTFILE="${XDG_STATE_HOME}"/bash/history
export CARGO_HOME="$XDG_DATA_HOME"/cargo

[[ -f ${HOME}/.cargo/env ]] && . "$HOME/.cargo/env"

# Starting X if tty1
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
#    exec nohup startx > .xlog & vlock
	if [[ -f sway ]]; then
    	echo Starting  Sway...
    	sleep 1
		exec sway
	else
		echo Starting  X...
		sleep 1
		exec startx
	fi
    # exec startx
    # There is a significant security difference when using plain startx 
    # instead of a login manager. Thus you run startx from your shell you 
    # are always able to switch from X (usually on tt7) back to 
    # tty1 (Ctrl+Alt+F1) and gain control over the user shell even when 
    # the screen is locked (e.g., via XScreenSaver, i3lock, etc.). 
    # A solution: replace 
    #    exec startx 
    # with 
    #    exec nohup startx > .xlog & vlock
    # This will start X, redirect the print out to ~/.xlog and lock the shell. 
    # Of course you need to install vlock first.
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# echo "========== Exiting .profile ==========" 

