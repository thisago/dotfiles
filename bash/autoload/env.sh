#!/usr/bin/env bash

# https://github.com/dom96/choosenim/blob/master/analytics.md
export DO_NOT_TRACK=1

# We always use Copilot Proxy for OpenAI API calls
export OPENAI_API_BASE='http://localhost:8923'
export OPENAI_API_KEY='sk-doesnt-matter'

# Set the timezone to Sao Paulo
export TZ='America/Sao_Paulo'
