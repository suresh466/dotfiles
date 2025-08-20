alias vim=nvim
alias cat=bat
# alias find=fd
# alias grep=rg
# alias du=dust
# alias ls=eza

alias qute-font="lsof -p $(pgrep qutebrowser) | awk '/fonts/ {print $NF}'"
alias fc-np-list="fc-list -f '%{file}\n' :lang=np"
alias ssp='systemctl suspend'
alias sp='systemctl poweroff'
alias lvim='XDG_CONFIG_HOME=~/software/lazy-vim XDG_DATA_HOME=~/.local/share/lazy-vim XDG_CACHE_HOME=~/.cache/lazy-vim XDG_STATE_HOME=~/.local/state/lazy-vim XDG_RUNTIME_DIR=/run/user/$(id -u)/lazy-vim nvim'
alias docker-desktop='/opt/docker-desktop/bin/com.docker.backend'
