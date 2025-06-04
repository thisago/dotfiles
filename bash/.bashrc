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
__startup_init

source "$dir/internal/dotenv.sh"

# Store the files to auto-load
autoload_files=($dir/autoload/*.sh)

for file in "${autoload_files[@]}"; do
  # Show a loading on the same line, replacing the previous one
   __startup_loading "$(basename "$file")"
  source "$file"
done

__startup_message "${autoload_files[@]}"
