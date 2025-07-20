#!/usr/bin/env bash

# Makefile completion script for bash

_make_targets() {
  local makefile cur
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"

  # Find the Makefile (default or via -f flag)
  makefile=Makefile
  for ((i=1; i < ${#COMP_WORDS[@]}; i++)); do
    if [[ "${COMP_WORDS[i]}" == "-f" && $((i+1)) -lt ${#COMP_WORDS[@]} ]]; then
      makefile="${COMP_WORDS[i+1]}"
      break
    fi
  done

  [[ -f "$makefile" ]] || return 0

  # Extract only real targets (not variables, not special targets)
  local targets
  targets=$(awk -F: '
    /^[^# \t][^=]*:/ && $1 !~ /^\./ && $0 !~ /^[^:]+::/ && $0 !~ /^[^:]+:=[^=]/ {
      print $1
    }
  ' "$makefile" | grep -v '^[ \t]*$' | sort -u)

  COMPREPLY=( $(compgen -W "${targets}" -- "$cur") )
}

complete -F _make_targets make
