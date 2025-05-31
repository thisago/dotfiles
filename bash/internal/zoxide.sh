#!/usr/bin/env bash

# If non-interactive shell, return
[[ $- != *i* ]] && return

# Initialize zoxide if available
[[ -n "$NONINTERACTIVE" ]] && return

if command -v zoxide &> /dev/null; then
  eval "$(zoxide init bash)"
fi
