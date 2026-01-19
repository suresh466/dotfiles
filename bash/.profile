# ~/.profile: executed by the command interpreter for login shells.

# --- 1. Source .bashrc if running bash ---
# This ensures that your aliases and prompt are loaded if the login shell is bash.
if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi

# --- 2. Environment Variables ---
# Define session-wide variables here.

# Default Editors
export VISUAL=nvim
export EDITOR="$VISUAL"

# Pager settings (Man pages & Less)
export MANPAGER="nvim +Man!"
export LESS="-R"

# Compiler Colors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Node.js Manager (n)
export N_PREFIX="$HOME/.local/n"

# --- 3. PATH Configuration ---
# Add directories to PATH only if they exist and aren't already there.

# Helper function to safe-prepend to PATH
path_prepend() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="$1:$PATH"
  fi
}

# Helper function to safe-append to PATH
path_append() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="$PATH:$1"
  fi
}

# User Binaries (Prepend: Higher Priority)
path_prepend "$HOME/bin"
path_prepend "$HOME/.local/bin"
path_prepend "$HOME/.cargo/bin"

# System/Tool Binaries (Append: Lower Priority)
# Go
if [[ ":$PATH:" != *":/usr/local/go/bin:"* ]]; then
  PATH="$PATH:/usr/local/go/bin"
fi

# JetBrains Toolbox
if [[ ":$PATH:" != *":/home/hawk/.local/share/JetBrains/Toolbox/scripts:"* ]]; then
  PATH="$PATH:/home/hawk/.local/share/JetBrains/Toolbox/scripts"
fi

# N (Node) - Uses its own logic to append
[[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"

# Lesspipe (Preprocessor for less)
eval "$(SHELL=/bin/sh lesspipe.sh)"

# Cleanup helper functions
unset -f path_prepend path_append
