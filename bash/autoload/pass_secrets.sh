#!/usr/bin/env bash

# Here we'll expose some secrets to the environment present in the `pass` store.

# Check if 'pass' command is available
[[ -n "$PASS_AVAILABLE" ]] || return

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

# Essential secrets for the environment

# Setup the Git user configuration
export GIT_AUTHOR_NAME="$(get_pass "user/name")"
export GIT_AUTHOR_EMAIL="$(get_pass "user/email")"
export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"

# Check if we should skip the loading of secrets due user preference
[[ "$DOTFILES_NO_SECRET_LOAD" != "" ]] && return

# Optional secrets

# Export secrets from the pass store
export OPENAI_API_KEY=$(get_pass "bash/openai_api_key")
