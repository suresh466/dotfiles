# ~/.bashrc: executed by bash(1) for non-login shells.

# --- 1. Interactive Check ---
# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# --- 2. History & Shell Options ---
# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
# Append to the history file, don't overwrite it
shopt -s histappend
# History length
HISTSIZE=10000
HISTFILESIZE=20000
# Check window size after each command
shopt -s checkwinsize

# --- 3. Prompt (PS1) ---
color_prompt=yes
if [ "$color_prompt" = yes ]; then
  PS1='\[\033[1m\]\[\033[31m\][\[\033[33m\]\u\[\033[32m\]@\[\033[34m\]\h \[\033[35m\]\W\[\033[31m\]]\[\033[37m\]\$ \[\033[0m\]'
else
  # use tput for color
  PS1='\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]'
fi
unset color_prompt

# --- 4. Aliases ---
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# Enable color support of ls
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  # alias grep='grep --color=auto'
fi

# --- 5. Completions ---
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# --- 6. Custom Tools & Bindings ---

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
