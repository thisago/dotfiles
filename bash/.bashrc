#!/usr/bin/env bash

# Export 'SHELL' to child processes.
# Programs such as 'screen' honor it and otherwise use /bin/sh.
export SHELL

if [[ $- != *i* ]] || [[ $TERM == "dumb" ]]; then
  [[ -n "$SSH_CLIENT" ]] && source /etc/profile
fi

dir="$(dirname "$(realpath ~/.bashrc)")"

# Load the internal startup script
source "$dir/internal/startup.sh"
__startup_init

# Load all autoload scripts
for file in `ls $dir/autoload/*.sh`; do
  # Show a loading on the same line, replacing the previous one
  __startup_loading "$(basename "$file")"
  source "$file"
done

# Show a startup message
__startup_message
