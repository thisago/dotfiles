#!/usr/bin/env bash

# If non-interactive shell, return
__isinteractive_is_interactive || return

# Check if 'minikube' command is available
command -v minikube &> /dev/null || return

# Set Minikube shell completion file
export MINIKUBE_SHELL_COMPLETION_FILE="$HOME/.minikube/shell-completion.sh"

# Create the directory for Minikube shell completion if file doesn't exist
if [ ! -f "$MINIKUBE_SHELL_COMPLETION_FILE" ]; then
  mkdir -p "$(dirname "$MINIKUBE_SHELL_COMPLETION_FILE")"
fi

# Generate Minikube shell completion file if it doesn't exist
if ! [ -f "$MINIKUBE_SHELL_COMPLETION_FILE" ]; then
  minikube completion bash > "$MINIKUBE_SHELL_COMPLETION_FILE"
  if [ $? -eq 0 ]; then
    source "$MINIKUBE_SHELL_COMPLETION_FILE"
  else
    echo "Failed to generate Minikube shell completion file."
  fi
fi

source "$MINIKUBE_SHELL_COMPLETION_FILE"
