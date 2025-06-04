#!/usr/bin/env bash

# Loacs `.env` file and exports its variables to the environment.

# Define the path to the dotenv file
DOTFILES_DOTENV_FILE="$(dirname "${BASH_SOURCE[0]}")/.env"

# Check if the dotenv file exists
if [[ -f "$DOTFILES_DOTENV_FILE" ]]; then
  # Load the dotenv file
  export $(grep -v '^#' "$DOTFILES_DOTENV_FILE" | xargs)
else
  echo "Warning: Dotenv file '$DOTFILES_DOTENV_FILE' not found." >&2
  echo "Please create it in order to use your bash propertly." >&2
fi

# Load the dotenv file if it exists
__dotenv_load() {
  source "$DOTFILES_DOTENV_FILE" 2>/dev/null || {
    echo "Error: Failed to load dotenv file '$DOTFILES_DOTENV_FILE'." >&2
    return 1
  }
}
