# ~/.bashrc: executed by bash(1) for non-login shells.

# --- Interactive Check ---
# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# --- History & Shell Options ---
# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
# Append to the history file, don't overwrite it
shopt -s histappend
# History length
HISTSIZE=10000
HISTFILESIZE=20000
# Check window size after each command
shopt -s checkwinsize

# --- Prompt (PS1) ---
color_prompt=yes
if [ "$color_prompt" = yes ]; then
  PS1='\[\033[1m\]\[\033[31m\][\[\033[33m\]\u\[\033[32m\]@\[\033[34m\]\h \[\033[35m\]\W\[\033[31m\]]\[\033[37m\]\$ \[\033[0m\]'
else
  # use tput for color
  PS1='\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]'
fi
unset color_prompt

# --- Aliases ---
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# Enable color support of ls
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  # alias grep='grep --color=auto'
fi

# --- Completions ---
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Lesspipe (Preprocessor for less)
eval "$(SHELL=/bin/sh lesspipe.sh)"

# --- Environment Variables ---
export BAT_THEME="gruvbox-dark"
# Default Editors
export VISUAL=nvim
export EDITOR="$VISUAL"
# Pager settings (Man pages & Less)
export MANPAGER="nvim +Man!"
export LESS="-R"
# Compiler Colors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add directories to PATH only if they exist and aren't already there.
# Helper function to safe-prepend to PATH (higher priority)
path_prepend() {
  if [ -d "$1" ]; then
    if [[ ":$PATH:" != *":$1:"* ]]; then
      # If PATH is empty, set to $1. Else, $1:$PATH
      PATH="$1${PATH:+:${PATH}}"
    fi
  else
    echo "Error: Directory '$1' does not exist." >&2
    return 1
  fi
}
# Helper function to safe-append to PATH (lower priority)
path_append() {
  if [ -d "$1" ]; then
    if [[ ":$PATH:" != *":$1:"* ]]; then
      # If PATH is empty, set to $1. Else, $PATH:$1
      PATH="${PATH:+${PATH}:}$1"
    fi
  else
    echo "Error: Directory '$1' does not exist." >&2
    return 1
  fi
}

# Prepend: Higher Priority
path_prepend "$HOME/.local/bin"
path_prepend "$HOME/.cargo/bin"

# SSH Agent Management (keychain)
eval $(keychain --eval --quiet)

# Tmux Sessionizer (tms)
source <(COMPLETE=bash tms)
bind -x '"\C-af": tms'
bind -x '"\C-as": tms switch'
# Source custom tms wrapper function
if [ -f ~/.tms_exec ]; then
  . ~/.tms_exec
fi

# Node.js Manager (n)
export N_PREFIX="$HOME/.local/n"
path_prepend "$N_PREFIX/bin"

# Cleanup helper functions
unset -f path_prepend path_append
