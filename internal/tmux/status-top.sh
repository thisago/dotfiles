#!/usr/bin/env bash

# Prints the hostname and the intention of current session.

workflowsDir=~/.workflows/
if test -d "$workflowsDir"; then
  sessionFile="$workflowsDir/session.json"
  sessionPretension="$(cat $sessionFile | jq -r .pretend)"

  echo -ne " $HOSTNAME 󱞁 $sessionPretension"
fi
