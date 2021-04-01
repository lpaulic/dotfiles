#bootstrap
if [ ! -d ${XDG_CONFIG_HOME}/zsh/spaceship ]; then
	echo "boostraping zsh prompt..."
	git clone https://github.com/denysdovhan/spaceship-prompt.git --depth=1 ${XDG_CONFIG_HOME}/zsh/spaceship
	mkdir ${XDG_CONFIG_HOME}/zsh/.zfunctions
	ln -s ${XDG_CONFIG_HOME}/zsh/spaceship/spaceship.zsh ${XDG_CONFIG_HOME}/zsh/.zfunctions/prompt_spaceship_setup
	clear
fi

fpath=( $XDG_CONFIG_HOME/zsh/.zfunctions $fpath)
autoload -U promptinit && promptinit
prompt spaceship
