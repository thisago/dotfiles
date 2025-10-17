#!/usr/bin/env bash

# If non-interactive shell, return
__isinteractive_is_interactive || return

# Check if 'hauler' command is available
command -v hauler &> /dev/null || return

# Set hauler shell completion file
export HAULER_SHELL_COMPLETION_FILE="$HOME/.local/share/shell-completion.sh"

# Create the directory for hauler shell completion if file doesn't exist
if [ ! -f "$HAULER_SHELL_COMPLETION_FILE" ]; then
  mkdir -p "$(dirname "$HAULER_SHELL_COMPLETION_FILE")"
fi

# Load hauler shell completion
if [ -f "$HAULER_SHELL_COMPLETION_FILE" ]; then
  source "$HAULER_SHELL_COMPLETION_FILE"
else
  # Generate hauler shell completion file if it doesn't exist
  hauler completion bash > "$HAULER_SHELL_COMPLETION_FILE"
  if [ $? -eq 0 ]; then
    source "$HAULER_SHELL_COMPLETION_FILE"
  else
    echo "Failed to generate hauler shell completion file."
  fi
fi
