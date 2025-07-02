#!/usr/bin/env bash

# If non-interactive shell, return
__isinteractive_is_interactive || return

# Check if 'aider' command is available
command -v aider &> /dev/null || return

# Set Aider shell completion file
export AIDER_SHELL_COMPLETION_FILE="$HOME/.config/aider/shell-completion.bash"

# Create the directory for Aider shell completion if file doesn't exist
if [ ! -f "$AIDER_SHELL_COMPLETION_FILE" ]; then
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

# Aliase  s
alias aiderw="aider --watch-files --chat-mode architect --auto-accept-architect"
