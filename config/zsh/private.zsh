source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border --history=$HISTFILE"
if [ -e "$HOME/.cargo/env" ]; then
    source "$HOME/.cargo/env"
fi
export WINIT_X11_SCALE_FACTOR=1 # alacrytty DP scaling disable
