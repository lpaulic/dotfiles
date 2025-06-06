test -e /usr/share/fzf/key-bindings.zsh && source /usr/share/fzf/key-bindings.zsh
test -e /usr/share/fzf/completion.zsh && source /usr/share/fzf/completion.zsh
export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border --history=$HISTFILE"

test -e "$HOME/.cargo/env" && source "$HOME"/.cargo/env
