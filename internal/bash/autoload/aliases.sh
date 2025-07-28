#!/usr/bin/env bash

# Exit if running in a non-interactive shell
__isinteractive_is_interactive || return

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'

# If 'eza' command is available, set it as 'exa'
if command -v eza &> /dev/null; then
  alias exa='eza'
fi

# If 'exa' command is available, set it as 'ls'
if command -v eza &> /dev/null; then
  alias ls='exa -F --git'
else
  alias ls='ls -F'
fi

# Set aliases for `ls` commands
alias la='ls -la'
alias lt='ls -T'
alias las='la --total-size -s size'

# Set aliases for disk usage commands
alias df='df -h'
alias du='du -h'

# Set aliases for grep commands with color
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# If `batcat` command is available, set it as `bat`
if command -v batcat &> /dev/null; then
  alias bat='batcat'
fi

# If `xclip` command is available, set aliases
if command -v xclip &> /dev/null; then
  alias xclipboard='xclip -selection clipboard'
fi
