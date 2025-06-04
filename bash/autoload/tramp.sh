#!/usr/bin/env bash

# Fix tramp prompt

# If term is not "dumb", return
[[ "$TERM" != 'dumb' ]] && return

# Set the prompt for tramp
export PROMPT_COMMAND='$ '
