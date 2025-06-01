#!/usr/bin/env bash

# If non-interactive shell, return
__isinteractive_is_interactive || return

# If tmux not installed, return
command -v tmux &> /dev/null || return

# Set the path to tmux configuration
TMUX_CONF="${HOME}/.config/tmux/tmux.conf"

# If tmux configuration does not exist, return
[ ! -f "$TMUX_CONF" ] && return

# If not inside tmux an in a TTY terminal, start tmux
if [ -z "$TMUX" ] && [ -t 0 ]; then
  # Attach if tmux session exists, otherwise create a new one
  tmux attach -d || exec tmux new-session -A -s main-tmux
fi
