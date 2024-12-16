#set XDG path
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# Session
export XDG_SESSION_TYPE=wayland
#export XDG_SESSION_DESKTOP=Hyprland
#export XDG_CURRENT_DESKTOP=Hyprland

# Wayland stuff
export WLR_NO_HARDWARE_CURSOR=1
export WLR_RENDERER_ALLOW_SOFTWARE=1
export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM=wayland
export SDL_VIDEODRIVER=wayland
export _JAVA_AWT_WM_NONREPARENTING=1

#set PATH
export PATH="$PATH:/sbin/"

#set EDITOR
if which nvim &>/dev/null; then
	export EDITOR="nvim"
else
	export EDITOR="vi"
fi

#  set locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# set  architecture
export arch=x86_64

# set dotfile environemnt variables
export DOTREPO="${HOME}/.dotfiles"
export DOTDROP_CONFIG="${DOTREPO}/config/dotdrop/config.yaml"
# the HOST follows the following template <profile>-<machine-sn-last-4-character>
export DOTDROP_PROFILE="$(echo ${HOST} | cut -d '-' -f 1)"

# set default C and CPP compilers
# CC=clang
# CXX=clang++

# set terminal
export TERM=alacritty

# set terminal window titles
precmd() {print -Pn "\e]0;%~\a"}
