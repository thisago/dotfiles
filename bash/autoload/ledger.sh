#!/usr/bin/env bash

# Check if 'ledger' command is available
command -v ledger &> /dev/null || return

# Set environment variables for Ledger
export LEDGER_FILE="$HOME/Documents/lj/journal.ledger"
