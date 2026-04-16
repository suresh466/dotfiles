# ~/.profile: executed by the command interpreter for login shells.

# --- 1. Source .bashrc if running bash ---
# This ensures that your aliases and prompt are loaded if the login shell is bash.
if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi
