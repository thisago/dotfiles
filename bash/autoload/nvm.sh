#!/usr/bin/env bash

# Set environment variables for Node Version Manager (nvm)
export NVM_DIR="${HOME}/.nvm"

# If `.nvm` doesn't exists, exit
test -d "$NVM_DIR" || return

# If non-interactive shell, return
__isinteractive_is_interactive || return

# Load nvm if the script exists
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
