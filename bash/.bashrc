#!/usr/bin/env bash

# Export 'SHELL' to child processes.
# Programs such as 'screen' honor it and otherwise use /bin/sh.
export SHELL

if [[ $- != *i* ]] || [[ $TERM == "dumb" ]]; then
  [[ -n "$SSH_CLIENT" ]] && source /etc/profile
fi

dir="$(dirname "$(realpath ~/.bashrc)")"
for file in `ls $dir/internal/*.sh`; do
  source "$file"
done
