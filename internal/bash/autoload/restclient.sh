#!/usr/bin/env bash

# Only enable completion if RESTCLIENT_DIR is set and non-empty
[ -z "$RESTCLIENT_DIR" ] && return

# Check deps
if ! command -v fd &>/dev/null; then
  echo 'fd is not installed.'
  return
fi

# Bash completion for restclient command - lists .http/.rest files from RESTCLIENT_DIR
_restclient_httpfiles_complete() {
  local cur
  cur="${COMP_WORDS[COMP_CWORD]}"
  # Find all .http and .rest files in RESTCLIENT_DIR, basename only
  local files
  files=$(cd "$RESTCLIENT_DIR" && fd '.http$' | sed -r 's/^(.*).http$/  \1/')
  COMPREPLY=($(compgen -W "$files" -- "$cur"))
}

# Register the completion function for the restclient command
complete -F _restclient_httpfiles_complete restclient
