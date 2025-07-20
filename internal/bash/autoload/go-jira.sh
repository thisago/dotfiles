#!/usr/bin/env bash

# If non-interactive shell, return
__isinteractive_is_interactive || return

# Check if `jira` command is available. Exit if not found.
command -v jira >/dev/null 2>&1 || return

# Evaluate completion script for `jira` command
eval "$(jira --completion-script-bash)"
