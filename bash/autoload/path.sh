#!/usr/bin/env bash

add_path() {
  # Ignore if the argument is not a directory
  if [[ ! -d "$1" ]]; then
    echo "Error: '$1' is not a directory."
    return 1
  fi

  # Check if the directory is already in PATH
  [[ "$PATH" == *"$1"* ]] && return 0

  # Add the directory to PATH
  export PATH="$1:$PATH"
}

# Add common directories to PATH
add_path "$HOME/.local/bin"

# Compiled binaries directory
add_path "$HOME/go/bin"

# Other packages managers
add_path "$HOME/.bun/bin"
add_path "$HOME/.config/emacs/bin"
add_path "$HOME/.nimble/bin"

# Loop over all .local/bin subdirectories and add them to PATH
for dir in "$HOME/.local/bin"/*; do
  if [[ -d "$dir" ]]; then
    add_path "$dir"
  fi
done
