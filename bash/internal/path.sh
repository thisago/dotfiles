#!/usr/bin/env bash

add_path() {
  export PATH="$1:$PATH"
}

# Add common directories to PATH
add_path "$HOME/.local/bin"
