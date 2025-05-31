#!/usr/bin/env bash

# Check if 'nvm' command is available
command -v nvm &> /dev/null || return

# Set environment variables for Node Version Manager (nvm)
export NVM_DIR="${HOME}/.nvm"

# Load nvm if the script exists
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
