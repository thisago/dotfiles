#!/usr/bin/env bash
# Go version manager

# Set environment variables for Go
export GOROOT="${HOME}/.g/go"
export G_MIRROR=https://golang.google.cn/dl/

# Source env file if it exists
if [[ -f "${HOME}/.g/env" ]]; then
  source "${HOME}/.g/env"
fi
