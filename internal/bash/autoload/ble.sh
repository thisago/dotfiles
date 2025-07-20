#!/usr/bin/env bash

# If non-interactive shell, return
__isinteractive_is_interactive || return

# Set the path to ble.sh
BLE_BIN="${HOME}/.local/share/blesh/ble.sh"

# If ble.sh does not exist, return
[ ! -f "$BLE_BIN" ] && return

# Source the ble.sh script
source "$BLE_BIN"

# Keybindings for ble.sh
ble-bind -f 'M-C-?' kill-backward-cword
ble-bind -f 'M-DEL' kill-backward-cword
ble-bind -f 'M-C-?' kill-backward-fword
ble-bind -f 'M-DEL' kill-backward-fword
