#!/usr/bin/env bash

# If non-interactive shell, return
__isinteractive_is_interactive || return

# Enable colorized output
export CLICOLOR=1
export LSCOLORS=Exfxcxdxbxegedabagacad

# Colored man pages
man() {
  env \
  LESS_TERMCAP_mb=$'\E[01;31m' \
  LESS_TERMCAP_md=$'\E[01;38;5;208m' \
  LESS_TERMCAP_me=$'\E[0m' \
  LESS_TERMCAP_se=$'\E[0m' \
  LESS_TERMCAP_ue=$'\E[0m' \
  LESS_TERMCAP_us=$'\E[04;38;5;111m' \
  man "$@"
}

# Prepend cd to directory names automatically
shopt -s autocd

# This allows you to bookmark your favorite places across the file system
shopt -s cdable_vars

# Correct spelling errors in arguments supplied to cd
shopt -s cdspell

# Checks the window size after each command
shopt -s checkwinsize

# Correct spelling errors during tab-completion
shopt -s dirspell

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar

# Match filenames in a case-insensitive fashion when performing filename expansion
shopt -s nocaseglob

# cd comand only autocompletes directories
complete -d cd

# EDITOR
export ALTERNATE_EDITOR=nano
export EDITOR=emacsclient

# Don't check mail when opening terminal
unset MAILCHECK

# gpg fix http://192.168.240.1:8000/stackoverflow.com_en_all_2023-11/questions/57591432/gpg-signing-failed-inappropriate-ioctl-for-device-on-macos-with-maven
GPG_TTY=$(tty)
export GPG_TTY
