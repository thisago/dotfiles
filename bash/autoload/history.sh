#!/usr/bin/env bash

# If not in an interactive shell, return immediately
__isinteractive_is_interactive || return

# Save all lines of a multiple-line command in the same history entry
shopt -s cmdhist

# Append to the history file, don't overwrite it
shopt -s histappend

# Huge history. Doesn't appear to slow things down, so why not?
export HISTSIZE=5000

# Avoid duplicate entries
export HISTCONTROL=ignoreboth

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:pwd:bg:fg:history:clear"
