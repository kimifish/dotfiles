# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# vim: fdm=marker

# Rsync TEST from openhome

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Setting DISPLAY if not set
#if [ -z ${DISPLAY+x} ]; then 
#	export DISPLAY=":0" 
#fi

# Looking good everywhere i use it
# export TERM=xterm-256color

# Bash options {{{
shopt -s cdspell                 # Correct cd typos
shopt -s checkwinsize            # Update windows size on command
shopt -s histappend              # Append History instead of overwriting file
shopt -s cmdhist                 # Bash attempts to save all lines of a multiple-line command in the same history entry
shopt -s expand_aliases
shopt -s extglob                 # Extended pattern
shopt -s no_empty_cmd_completion # No empty completion
set -o vi                        # Vi-like mod ON

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

#}}}
# Completion {{{
complete -cf sudo
if ! shopt -oq posix ; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
#}}}
# Bash history {{{
# make multiple shells share the same history file
export HISTSIZE=1000            # bash history will save N commands
export HISTFILESIZE=${HISTSIZE} # bash will remember N commands
export HISTCONTROL=ignoreboth   # ingore duplicates and spaces
export HISTIGNORE='&:ls:ll:la:lal:lsize:lasize:lmod:lamod:cd:..:...:....:exit:clear:history'
#}}}
# Fancy prompt {{{
if [ -f "$HOME/.bashrc.d/bash-ps1" ]; then
    . "$HOME/.bashrc.d/bash-ps1"
    PROMPT_COMMAND=__prompt_command
else
    # set variable identifying the chroot you work in (used in the prompt below)
    if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
    fi
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
# }}}
# Aliases and functions {{{

if [ -f ~/.bashrc.d/aliases ]; then
    . ~/.bashrc.d/aliases
fi
if [ -f ~/.bashrc.d/palettes ]; then
    . ~/.bashrc.d/palettes
fi
if [ -f ~/.bashrc.d/functions ]; then
    . ~/.bashrc.d/functions
fi
# }}}

#tmx
stty -ixon

# FZF {{{
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f /usr/share/doc/fzf/examples/completion.bash ] && source /usr/share/doc/fzf/examples/completion.bash
FZF_TMUX=1
FZF_TMUX_HEIGHT=25%
FZF_DEFAULT_OPTS='
  --color=bg+:#073642,bg:#002b36,spinner:#719e07,hl:#586e75
  --color=fg:#839496,header:#586e75,info:#cb4b16,pointer:#719e07
  --color=marker:#719e07,fg+:#839496,prompt:#719e07,hl+:#719e07
'
# }}}
# ROFI {{{
# Don't know how to use env vars in ROFI config, so creating it here.
#
cat > $HOME/.config/rofi/colors/dynamic.rasi <<EOL
* {
    background:     $PAL_ROFI_COL2;
    background-alt: $PAL_ROFI_COL3;
    foreground:     $PAL_ROFI_COL4;
    selected:       $PAL_ROFI_COL4;
    active:         $PAL_ROFI_COL3;
    urgent:         #FF0000FF;
}
EOL
# }}}

export VISUAL="/usr/bin/vim.basic"
export EDITOR="$VISUAL"
# Beautiful invitation {{{
# If palette is set, choosing host color of it.
[ -n "$PALETTE" ] && printf "\033[38;%s;%sm" "$PALETTE_COLOR_RANGE" "$PAL_COL3"

if type figlet >/dev/null 2>&1; then
    figlet -t -f small $(whoami)@$(hostname)
    if [[ -f "$(figlet -I2)/wideterm.tlf" ]] ; then
	os_font="wideterm"
    else
	os_font="term"
    fi
    [ -n "$PAL_COL2" ] && printf "\033[38;%s;%sm" "$PALETTE_COLOR_RANGE" "$PAL_COL4"
    figlet -t -f $os_font $(OS_Version)
    echo
fi
printf "\033[00m"
# }}}
[ -x "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
[ -d "$HOME/.nvm" ] && export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ `hostname` == 'f2-lr-sound' ] && return 0
# If NOTMUX set - exiting
[ -n "$NOTMUX" ] && [ "$NOTMUX" -eq 1 ] && return 0

# Tmux start {{{
# First - checking if there is a tmux app
command -v tmux &> /dev/null
tmux_exist=$?

# Second - checking if i'm loggin in by ssh or inside IDE
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
	if [ -n "$PHONE_SESSION" ]; then
		session_type="phone"
	else
		session_type="remote"
	fi
else
	if [[ "$TERM_PROGRAM" == "vscode" ]]; then
		session_type="IDE"
	else
    	session_type="local"
	fi
fi

# Third - checking if remote or local session exists
if [[ "$tmux_exist" == 0 ]]; then
    tmux has-session -t "$session_type" &> /dev/null
    session_exist=$?
fi

# Fourth - checking if i'm inside tmux already
if [ -n "$TMUX" ]; then
    inside_tmux=0
else
    inside_tmux=1
fi

# Fifth - checking for tmuxinator
command -v tmuxinator &> /dev/null
tmuxinator_exist=$?

# Now we have enough data:
#    - inside_tmux
#    - tmux_exist
#    - tmuxinator_exist
#    - session_exist
#    - session_type
true=0
false=1

# This section is purposed to divide local logins from ssh logins.
# If we are logging in locally, it tries to find tmux session 
# named 'local' and attach to it.
# If we are ssh'ing - searching for session named 'remote' 
# In both cases, if session doesn't exist, it tries to create it.
# And, if teamocil installed, it searches for 
# ~/.teamocil/$hostname-$session.yml and loads it to new session.
#
# If we are running 'tmux' from existing terminal shell,
# it does nothing presuming that you just detached from tmux and
# want new session instead.

if [[ "$tmux_exist" == "$true" ]]; then
	if [[ "$session_exist" == "$true" ]] ; then
		if [[ "$inside_tmux" == "$false" ]]; then
			echo "Attaching existing session $session_type"
			tmux attach-session -t "$session_type"
		fi
	else
	    if [[ "$inside_tmux" == "$false" ]]; then
		printf "Creating new session $session_type "
    		if [[ "$tmuxinator_exist" == "$true" ]]; then
				echo "with tmuxinator"
		        tmuxinator $HOSTNAME-$session_type
				#tmuxinator $HOSTNAME-$session_type
    		else
				echo "without tmuxinator"
    		    tmux new-session -s "$session_type"
    		fi
	    fi
	fi
else
   :
fi
# }}}

. "/home/kimifish/.local/share/cargo/env"
