#!/usr/bin/env bash

# Prints the percentage of time passed in a session considering the expected duration and the date and time.

workflowsDir=~/Documents/repos/asciicasts/workflow/
if test -d "$workflowsDir"; then
  nowEpoch="$(date '+%s')"
  sessionFile="$workflowsDir/session.json"
  if [[ -f "$sessionFile" ]]; then
    sessionData="$(jq -r '(.start | tostring) + " " + (.expectedDuration | tostring) + " " + (.stdin | tostring)' < "$sessionFile")"

    sessionStartEpoch="$(awk '{print $1}' <<< "$sessionData")"
    expectedMins="$(awk '{print $2}' <<< "$sessionData")"
    isStdinEnabled="$(awk '{print $3}' <<< "$sessionData")"

    epochDiffPassed="$(echo "$nowEpoch - $sessionStartEpoch" | bc)"
    passedPercentage="$(echo "($epochDiffPassed / ($expectedMins * 60)) * 100" | bc -l | sed -r 's/([0-9]{1,3}).*/\1/')"
    minsPassed="$(echo "($epochDiffPassed / 60)" | bc)"

    [[ "$isStdinEnabled" == "true" ]] && echo -n "  "

    icon="󱎫"
    [[ "$minsPassed" -gt "$expectedMins" ]] && icon="󰀠 "

    # passed percentage / remaining minutes / passed minuntes / size / cast duration in hours
    echo -n "$icon ${passedPercentage}% "
  fi
fi

weekNumber="$(echo `date '+%U'` + 1 | bc)"
clock="$(date "+ %H:%M:%S 󰃭 %a%dW$weekNumber%b%Y")"
echo -n "$clock"
