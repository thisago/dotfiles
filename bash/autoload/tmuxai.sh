#!/usr/bin/env bash

# Exit if tmuxai is not installed
command -v tmuxai >/dev/null 2>&1 || return

# Define envs
export TMUXAI_OPENROUTER_API_KEY="$OPENAI_API_KEY"
export TMUXAI_OPENROUTER_BASE_URL="$OPENAI_API_BASE"
export TMUXAI_OPENROUTER_MODEL="gpt-4.1"
