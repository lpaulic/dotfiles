#set XDG path
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

#set EDITOR
if [[ -a "/usr/bin/nvim" ]]; then
	export EDITOR="nvim"
fi

#  set locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# set  architecture
export arch=x86_64

# set dotfile git repository location
export DOTREPO="${HOME}/Documents/SCM/GitHub/dotfiles"

# set default C and CPP compilers
CC=clang
CXX=clang++

# set terminal
export TERM=alacritty

# set terminal window titles
precmd() {print -Pn "\e]0;%~\a"}
