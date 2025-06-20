#!/usr/bin/env bash

# Here we'll expose some secrets to the environment present in the `pass` store.

# Check if 'pass' command is available
[[ -n "$PASS_AVAILABLE" ]] || return

# Check if we should skip due user configuration
[[ "$DOTFILES_NO_SECRET_LOAD" != "" ]] && return

# Define a helper that retrieves a secret from the pass store
get_pass() {
  local secret_path="$1"
  if [[ -z "$secret_path" ]]; then
    echo 'Error: No secret path provided.' >&2
    return 1
  fi

  # Use 'pass' to retrieve the secret, suppressing any error messages
  pass show "$secret_path" 2>/dev/null
}

# Export secrets from the pass store
export OPENAI_API_KEY=$(get_pass "bash/openai_api_key")
