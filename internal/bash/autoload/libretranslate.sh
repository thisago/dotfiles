#!/usr/bin/env bash

# Set environment variables for LibreTranslate if not set

[[ ! -n "$LIBRETRANSLATE_HOST" ]] && \
  export LIBRETRANSLATE_HOST='https://translate.disroot.org'
[[ ! -n "$LIBRETRANSLATE_DEFAULT_LANG" ]] && \
  export LIBRETRANSLATE_DEFAULT_LANG='en'
