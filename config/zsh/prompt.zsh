export STARSHIP_CONFIG=${XDG_CONFIG_HOME}/starship/starship.toml
export STARSHIP_CACHE=${XDG_CACHE_HOME}/starship/cache
which starship &>/dev/null && eval "$(starship init zsh)"
