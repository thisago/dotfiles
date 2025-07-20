#!/usr/bin/env bash

# Function to check if the terminal is interactive
__isinteractive_is_interactive() {
  # Check if the shell is interactive
  [[ $- == *i* ]] || return 1

  # Check if the TERM variable is set to a non-dumb terminal
  [[ -n "$TERM" && "$TERM" != "dumb" ]] || return 1

  # If not running inside an application
  [[ -n "$OR_APP_NAME" ]] && return 1

  return 0
}
