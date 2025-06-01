#!/usr/bin/env bash

# Check if 'libretranslate' command is available
command -v libretranslate &> /dev/null || return

# Set environment variables for LibreTranslate
export LIBRETRANSLATE_HOST="https://translate.disroot.org/"
export LIBRETRANSLATE_DEFAULT_LANG='en'
