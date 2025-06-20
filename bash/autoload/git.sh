#!/usr/bin/env bash

# If `git` not installed, return
command -v git >/dev/null 2>&1 || return

# Define the configuration envs
export GIT_AUTHOR_NAME="$DOTFILES_USER"
export GIT_COMMITTER_NAME="$DOTFILES_USER"
export GIT_AUTHOR_EMAIL="$DOTFILES_EMAIL"
export GIT_COMMITTER_EMAIL=" $DOTFILES_EMAIL"
