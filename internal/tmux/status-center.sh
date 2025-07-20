#!/usr/bin/env bash

# Prints the name of the currently focused window in a status bar format.

cd "$(dirname "$(realpath "$0")")" || exit 1

IGNORED_APPS=(
  '"Firefox" "org.mozilla.firefox"'
  '"org.mozilla.firefox" "org.mozilla.firefox"'
  '"gnome-shell" "Gnome-shell"'
  ''
)

IGNORED_APPS_REGEX="$(IFS="|"; echo -n "${IGNORED_APPS[*]}")"

windowName="$(xwininfo -root -children \
    | grep -vE "\(($IGNORED_APPS_REGEX)\)" \
    | head -n 7 | tail -n 1 \
    | sed -r 's/^ *(0x[^)]+) "([^"]+)": \(("([^"]+)" ?){2}?\) +([0-9]+x[0-9]+)(\+-?[0-9]+\+-?[0-9]+ *){2}/\2 (\5)/')"

echo -n "$windowName"
