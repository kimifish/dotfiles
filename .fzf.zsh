# Setup fzf
# ---------
if [[ ! "$PATH" == */home/kimifish/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/kimifish/.fzf/bin"
fi

source <(fzf --zsh)
