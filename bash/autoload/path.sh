#!/usr/bin/env bash

add_path() {
  # Ignore if the argument is not a directory
  if [[ ! -d "$1" ]]; then
    echo "Error: '$1' is not a directory."
    return 1
  fi
  # Check if the directory is already in PATH
  case ":$PATH:" in
    *":$1:"*)
      echo "Directory '$1' is already in PATH."
      return
      ;;
  esac
  # Add the directory to PATH
  export PATH="$1:$PATH"
}

# Add common directories to PATH

# .local/bin is a common place for user-installed scripts and binaries
# But it may not exist, so we create it if necessary, ignoring if it already exists
add_path "$HOME/.local/bin" > /dev/null

# Loop over all .local/bin subdirectories and add them to PATH
for dir in "$HOME/.local/bin"/*; do
  if [[ -d "$dir" ]]; then
    add_path "$dir"
  fi
done
