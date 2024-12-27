# Setup fzf
# ---------
if [[ ! "$PATH" == */home/kimifish/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/kimifish/.fzf/bin"
fi

eval "$(fzf --bash)"
export FZF_DEFAULT_OPTS='
--color=bg+:#293739,
        bg:#1B1D1E,
        border:#808080,
        spinner:#E6DB74,
        hl:#7E8E91,
        fg:#F8F8F2,
        header:#7E8E91,
        info:#A6E22E,
        pointer:#A6E22E,
        marker:#F92672,
        fg+:#F8F8F2,
        prompt:#F92672,
        hl+:#F92672
        '
export FZF_DEFAULT_OPTS="--color=\
bg+:$PAL_TMUX_COL1,\
bg:$PAL_TMUX_COL0,\
border:$PAL_TMUX_COL1,\
spinner:$PAL_TMUX_COL5,\
fg:$PAL_TMUX_COL3,\
header:#7E8E91,\
info:$PAL_TMUX_COL3,\
pointer:$PAL_TMUX_COL4,\
marker:#F92672,\
fg+:$PAL_TMUX_COL3,\
prompt:$PAL_TMUX_COL6,\
hl:$PAL_TMUX_COL4,\
hl+:$PAL_TMUX_COL4"
