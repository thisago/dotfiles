#!/usr/bin/env bash

# Prints the start time of the current session.

workflowsDir=~/.workflows/
if test -d "$workflowsDir"; then
  sessionFile="$workflowsDir/session.json"
  sessionPretension="$(cat $sessionFile | jq -r .pretend)"

  echo -ne "󱞁 $sessionPretension"
fi
