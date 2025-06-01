#!/usr/bin/env bash

# If non-interactive shell, return
__isinteractive_is_interactive || return

# Initialize zoxide if available
[[ -n "$NONINTERACTIVE" ]] && return

if command -v zoxide &> /dev/null; then
  eval "$(zoxide init bash)"
fi
