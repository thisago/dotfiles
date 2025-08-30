#!/usr/bin/env bash

# Prints the hostname, the name of current focused window and the intention of current session.

echo -n " $HOSTNAME"

IGNORED_APPS=(
  '"Firefox" "org.mozilla.firefox"'
  '"org.mozilla.firefox" "org.mozilla.firefox"'
  '"gnome-shell" "Gnome-shell"'
  '"mutter-x11-frames" "mutter-x11-frames"'
  '"ibus-x11" ""'
  ''
)

IGNORED_APPS_REGEX="$(
  IFS="|"
  echo -n "${IGNORED_APPS[*]}"
)"

rawWindows=$(xwininfo -root -children | grep -vE "\(($IGNORED_APPS_REGEX)\)" | grep -E '^ *0x')

if [[ "$(wc -l <<<"$rawWindows")" -gt 1 ]]; then
  windowName="$(echo "$rawWindows" |
    head -n1 |
    sed -r 's/^ *(0x[^)]+) "([^"]+)": \(("([^"]*)" ?){2}?\) +([0-9]+x[0-9]+)(\+-?[0-9]+\+-?[0-9]+ *){2}/\2 (\5)/')"

  echo -n "  $windowName"
fi

sessionFile=~/Documents/repos/asciicasts/workflow/session.json
if test -f "$sessionFile"; then
  sessionPretension=$(jq -r .pretend "$sessionFile")
  echo -n " 󱞁 $sessionPretension"
fi
