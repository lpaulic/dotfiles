
# load and configure zsh built in completions system
zmodload -i zsh/complist

zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*:processes' command 'ps -au -U $USER'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit && compinit -d $XDG_CONFIG_HOME/zsh/zcompdump

# load history completition
# autoload -Uz history-beginning-search-menu
# zle -N history-beginning-search-menu-end history-beginning-search-menu

