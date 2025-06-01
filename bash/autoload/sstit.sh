#!/usr/bin/env bash

# Check if 'sstit' command is available
command -v sstit &> /dev/null || return

# Set environment variables for sstit
export STTIT_OPENAI_WHISPER_API_HOST="http://192.168.15.179:8000"
export STTIT_OPENAI_WHISPER_API_KEY=""
export STTIT_OPENAI_WHISPER_API_MODEL="deepdml/faster-whisper-large-v3-turbo-ct2"

# if [[ "$HOSTNAME" != "work" ]] && [[ "$HOSTNAME" != "personal" ]]; then
#   export LIBRETRANSLATE_HOST="http://192.168.240.1:8084"
#   export STTIT_OPENAI_WHISPER_API_HOST="http://192.168.240.180:8000"
# fi
