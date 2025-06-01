#!/usr/bin/env bash
# Go version manager

# Check if 'g' command is available
command -v g &> /dev/null || return

# Set environment variables for Go
export GOROOT="${HOME}/.g/go"
export G_MIRROR=https://golang.google.cn/dl/
