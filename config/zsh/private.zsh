test -e /usr/share/fzf/key-bindings.zsh && source /usr/share/fzf/key-bindings.zsh
test -e /usr/share/fzf/completion.zsh && source /usr/share/fzf/completion.zsh
export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border --history=$HISTFILE"

test -e "$HOME/.cargo/env" && source "$HOME"/.cargo/env

test -e "$XDG_DATA_HOME/gem/ruby/3.4.0/bin" && export PATH="$XDG_DATA_HOME/gem/ruby/3.4.0/bin:$PATH"
test -e "$XDG_DATA_HOME/gem/ruby/3.4.0/bin" && export BUNDLE_PATH="$HOME/.gems"

