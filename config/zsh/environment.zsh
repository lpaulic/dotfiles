#set XDG path
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

#set EDITOR
if [[ -a "/usr/bin/vim" ]]; then
	export EDITOR="vim"
fi

#  set locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# set  architecture
export arch=x86_64

# set dotfile git repository location
export DOTREPO="${HOME}/Documents/github/dotfiles"
