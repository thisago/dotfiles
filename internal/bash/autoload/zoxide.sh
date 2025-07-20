#!/usr/bin/env bash

# If non-interactive shell, return
__isinteractive_is_interactive || return

# If not available, return
command -v zoxide &> /dev/null || return

# Initialize zoxide
eval "$(zoxide init bash)"
