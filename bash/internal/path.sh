#!/usr/bin/env bash

add_path() {
  export PATH="$1:$PATH"
}

# Add common directories to PATH
add_path "$HOME/.local/bin"

# Loop over all .local/bin subdirectories and add them to PATH
for dir in "$HOME/.local/bin"/*; do
  if [[ -d "$dir" ]]; then
    add_path "$dir"
  fi
done
