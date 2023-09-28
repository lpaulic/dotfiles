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
export DOTREPO="${HOME}/Documents/github/dotfiles"

# set default C and CPP compilers
#CC=clang
#CXX=clang++

# set terminal
export TERM=xterm

# set terminal window titles
precmd() {print -Pn "\e]0;%~\a"}

# set work aliases
export NFS=172.21.3.40
export BM01=172.21.3.35
export BM02=172.21.3.13
export BM03=172.21.3.33
export BM04=172.21.3.41
export BM05=172.21.3.42
export BM06=172.21.3.43
export BM07=172.21.3.45
export BM08=172.21.3.46
export BM09=172.21.3.60
export BM10=172.21.3.61
export BM12=172.21.3.68
export BM20=172.21.3.97
export BM14=172.21.3.86
export BM15=172.21.3.89
export BM21=172.21.3.104

