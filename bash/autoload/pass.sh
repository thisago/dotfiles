#!/usr/bin/env bash

# Check if 'pass' command is available
command -v pass &> /dev/null || return

# Set Pass shell completion file path
PASS_COMPLETION_FILE="/usr/share/bash-completion/completions/pass"

# Load Pass shell completion if available
if [ -f "$PASS_COMPLETION_FILE" ]; then
  source "$PASS_COMPLETION_FILE"
fi

# Set Environment Variable to inform we can use `pass`
export PASS_AVAILABLE=1
