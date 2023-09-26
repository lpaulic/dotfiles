source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border --history=$HISTFILE"

# launch VPN setup
if ! pgrep -f 'java -jar /usr/bin/cshell/CShell.jar /tmp/cshell.fifo' &> /dev/null; then
	/usr/bin/cshell/launcher &> /dev/null
fi
