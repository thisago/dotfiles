#!/usr/bin/env sh

# Create a directory and change into it
mkcd() {
  dir="$1"
  # Check if the argument is provided
  if [[ -z "$dir" ]]; then
    echo "Usage: mkcd <directory_name>"
    return 1
  fi

  # Create the directory ignoring errors if it already exists
  mkdir -p "$dir"

  cd "$dir"
  if [[ $? -ne 0 ]]; then
    echo "Failed to create or change into directory: $dir"
    return 1
  fi
}

# Create a new file and auto create the directory if not exist
touchp() {
  file="$1"
  # Check if the argument is provided
  if [[ -z "$file" ]]; then
    echo "Usage: touchp <file_path>"
    return 1
  fi

  # Check if the file exists
  if [[ -e "$file" ]]; then
    echo "File already exists: $file"
    return 1
  fi

  # Extract file path to create the directory if it doesn't exist
  dir="$(dirname "$file")"

  # Create the directory if it doesn't exist
  if [[ ! -d "$dir" ]]; then
    mkdir -p "$dir"
  fi

  # Create the file
  touch "$file"
}

# Run the command with EDITOR set as nano
wnano() {
  export EDITOR=nano
  $@
}
