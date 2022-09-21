#bootstrap
if [ ! -d ${XDG_CONFIG_HOME}/zsh/spaceship ]; then
	echo "boostraping zsh prompt..."
	git clone --depth=1 https://github.com/spaceship-prompt/spaceship-prompt.git ${XDG_CONFIG_HOME}/zsh/spaceship
#old way:	mkdir ${XDG_CONFIG_HOME}/zsh/.zfunctions
#old way:	ln -s ${XDG_CONFIG_HOME}/zsh/spaceship/spaceship.zsh ${XDG_CONFIG_HOME}/zsh/.zfunctions/prompt_spaceship_setup
	clear
fi

##old way
#fpath=( $XDG_CONFIG_HOME/zsh/.zfunctions $fpath)
#autoload -U promptinit && promptinit
#prompt spaceship

##new way
source "$XDG_CONFIG_HOME/zsh/spaceship/spaceship.zsh"

