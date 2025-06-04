#!/usr/bin/env bash

# Check if 'pass' command is available
command -v pass &> /dev/null || return

# Set Pass shell completion file path
PASS_COMPLETION_FILE="/usr/share/bash-completion/completions/pass"

# Load Pass shell completion if available
if [ -f "$PASS_COMPLETION_FILE" ]; then
  source "$PASS_COMPLETION_FILE"
fi

# resolveenv: Preprocess a .env file, resolving pass: references to secrets
#
# Usage:
#   resolveenv [input_env_file] [output_env_file]
#
# - Reads the input_env_file (default: .env)
# - For any line of the form VAR=pass:path/to/secret, replaces the value with
#   the output of `pass show path/to/secret` (first line only).
# - Writes the result to output_env_file (default: .env.resolved)
# - Lines that do not match the pattern are copied as-is.
#
# Example .env:
#   DB_PASSWORD=pass:cloud/aws.amazon.com/username/tokens/secret_key.gpg
#   API_KEY=pass:cloud/github.com/username/tokens/copilot.gpg
#   DEBUG=true
#
# Example usage:
#   resolveenv .env .env.resolved
#   # Now .env.resolved contains secrets, ready for use with dotenv loaders.
resolveenv() {
  local input="${1:-.env}"
  local output="${2:-.env.resolved}"

  # Check if pass is available
  command -v pass &> /dev/null || {
    echo "resolveenv: pass command not found." >&2
    return 1
  }

  # Check if input file exists
  if [[ ! -f "$input" ]]; then
    echo "resolveenv: input file '$input' not found." >&2
    return 1
  fi

  # Process each line
  > "$output"
  while IFS= read -r line || [[ -n "$line" ]]; do
    # Skip comments and empty lines
    if [[ "$line" =~ ^[[:space:]]*# ]] || [[ -z "$line" ]]; then
      echo "$line" >> "$output"
      continue
    fi

    # Parse KEY=VALUE pairs
    if [[ "$line" =~ ^([A-Za-z_][A-Za-z0-9_]*)=(.*)$ ]]; then
      key="${BASH_REMATCH[1]}"
      value="${BASH_REMATCH[2]}"
      # Remove surrounding quotes if present
      value="${value%\"}"
      value="${value#\"}"
      if [[ "$value" == pass:* ]]; then
        pass_path="${value#pass:}"
        # Only use the first line of the secret
        secret="$(pass show "$pass_path" 2>/dev/null | head -n1)"
        value="$secret"
      fi
      # Quote the value if it contains spaces or special chars
      if [[ "$value" =~ [[:space:]\#\$\`] ]]; then
        value="\"$value\""
      fi
      echo "$key=$value" >> "$output"
    else
      # Copy lines that don't match KEY=VALUE as-is
      echo "$line" >> "$output"
    fi
  done < "$input"
}
