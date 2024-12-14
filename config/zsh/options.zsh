#-----------------------------------------------------------------------
# KEY BINDINGS
# note1: run cat -v and then press the key to see what is the output
# note2: man zshzle for widget description
#-----------------------------------------------------------------------
HOME_KEY='^[[H'
END_KEY='^[[F'
INSERT_KEY='^[[2~'
DELETE_KEY='^[[3~'
UP_KEY='^[[A'
DOWN_KEY='^[[B'
LEFT_KEY='^[[D'
RIGHT_KEY='^[[C'
PAGEUP_KEY='^[[5~'
PAGEDOWN_KEY='^[[6~'
#ESC_KEY='^['
CTRL_LEFT_KEY='^[[1;5D'
CTRL_RIGHT_KEY='^[[1;5C'

bindkey  	${HOME_KEY}             beginning-of-line
bindkey  	${END_KEY}              end-of-line
bindkey  	${INSERT_KEY}           overwrite-mode
bindkey  	${DELETE_KEY}           delete-char
bindkey  	${UP_KEY}				history-beginning-search-backward
bindkey  	${DOWN_KEY}             history-beginning-search-forward
bindkey		${LEFT_KEY}				backward-char
bindkey  	${RIGHT_KEY}	        forward-char
bindkey 	${PAGEUP_KEY}	        history-beginning-search-backward
bindkey 	${PAGEDOWN_KEY}         history-beginning-search-forward
#bindkey 	${ESC_KEY}				kill-whole-line
bindkey     ${CTRL_LEFT_KEY}        backward-word
bindkey     ${CTRL_RIGHT_KEY}       forward-word
bindkey 	'^H' 					history-beginning-search-menu-end
bindkey     '^k'                    delete-word
bindkey     '^u'                    backward-delete-word

# COMPLETITION SYSTEM
setopt completealiases
setopt complete_in_word
setopt always_to_end

# HISTORY
HISTSIZE=1024
SAVEHIST=1024
HISTFILE=$XDG_CACHE_HOME/zsh_history
setopt hist_ignore_all_dups
# unsetopt share_history
setopt share_history

#MISC
KEYTIMEOUT=1
unsetopt rm_star_silent
setopt auto_cd
