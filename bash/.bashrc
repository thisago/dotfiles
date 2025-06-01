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
source "$dir/internal/isinteractive.sh"
__isinteractive_is_interactive && __startup_init

for file in `ls $dir/autoload/*.sh`; do
  # Show a loading on the same line, replacing the previous one
  __isinteractive_is_interactive && __startup_loading "$(basename "$file")"
  source "$file"
done

__isinteractive_is_interactive && __startup_message
