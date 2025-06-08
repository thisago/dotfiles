#!/usr/bin/env bash

# Exit if running in a non-interactive shell
__isinteractive_is_interactive || return

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../../'

# If 'eza' command is available, set it as 'exa'
if command -v exa &> /dev/null; then
  alias exa='eza'
fi

# If 'exa' command is available, set it as 'ls'
if command -v eza &> /dev/null; then
  alias ls='exa -F --git'
else
  alias ls='ls -F'
fi

# Set aliases for `ls` commands
alias la='ls -la'
alias lt='ls -T'
alias las='la --total-size -s size'

# Set aliases for disk usage commands
alias df='df -h'
alias du='du -h'

# Set aliases for grep commands with color
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# If `batcat` command is available, set it as `bat`
if command -v batcat &> /dev/null; then
  alias bat='batcat'
fi

# If `xclip` command is available, set aliases
if command -v xclip &> /dev/null; then
  alias xclipboard='xclip -selection clipboard'
fi

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
