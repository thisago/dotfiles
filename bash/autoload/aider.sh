#!/usr/bin/env bash

# Check if 'aider' command is available
command -v aider &> /dev/null || return

# Set Aider shell completion file
export AIDER_SHELL_COMPLETION_FILE="$HOME/.config/aider/shell-completion.bash"

# Create the directory for Aider shell completion if it doesn't exist
if [ ! -d "$(dirname "$AIDER_SHELL_COMPLETION_FILE")" ]; then
  mkdir -p "$(dirname "$AIDER_SHELL_COMPLETION_FILE")"
fi

# Load Aider shell completion
if [ -f "$AIDER_SHELL_COMPLETION_FILE" ]; then
  source "$AIDER_SHELL_COMPLETION_FILE"
else
  # Generate Aider shell completion file if it doesn't exist
  aider --shell-completion bash > "$AIDER_SHELL_COMPLETION_FILE"
  if [ $? -eq 0 ]; then
    source "$AIDER_SHELL_COMPLETION_FILE"
  else
    echo "Failed to generate Aider shell completion file."
  fi
fi
