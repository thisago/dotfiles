#!/usr/bin/env bash

# Set color variables for terminal output

# Normal colors
export BLACK='\033[0;30m'
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export GRAY='\033[0;37m'

# Light colors
export LBLACK='\033[0;90m'
export LRED='\033[0;91m'
export LGREEN='\033[0;92m'
export LYELLOW='\033[0;93m'
export LBLUE='\033[0;94m'
export LPURPLE='\033[0;95m'
export LCYAN='\033[0;96m'
export LWHITE='\033[0;97m'
export LGRAY="$GRAY"

# Bold colors
export BGRAY='\033[1;30m'
export BRED='\033[1;31m'
export BGREEN='\033[1;32m'
export BYELLOW='\033[1;33m'
export BBLUE='\033[1;34m'
export BPURPLE='\033[1;35m'
export BCYAN='\033[1;36m'
export BWHITE='\033[1;37m'
export BGRAY="$WHITE"

# Bold light colors
export BLBLACK='\033[1;90m'
export BLRED='\033[1;91m'
export BLGREEN='\033[1;92m'
export BLYELLOW='\033[1;93m'
export BLBLUE='\033[1;94m'
export BLPURPLE='\033[1;95m'
export BLCYAN='\033[1;96m'
export BLWHITE='\033[1;97m'
export BLGRAY="$BWHITE"

# Extras
export RESET='\033[0m'
export COLOR_REVERSE_BG_FG='\033[7m'
export COLOR_UNDERLINE='\033[4m'
export COLOR_BLINK='\033[5m'

# Special escape sequences to manipulate the line and buffer
export LINE_START='\033[1G'
export LINE_END='\033[0K'
export CLEAR_SCREEN='\033[2J'
export CLEAR_LINE='\033[2K'
export SAVE_CURSOR='\033[s'
export RESTORE_CURSOR='\033[u'
export CURSOR_UP='\033[1A'
export CURSOR_DOWN='\033[1B'
export CURSOR_FORWARD='\033[1C'
export CURSOR_BACK='\033[1D'
export SCROLL_UP='\033[S'
export SCROLL_DOWN='\033[T'
export ERASE_TO_END_OF_LINE='\033[K'
export ERASE_TO_END_OF_SCREEN='\033[J'
export HIDE_CURSOR='\033[?25l'
export SHOW_CURSOR='\033[?25h'

# Cursor Positioning (CUP): Move cursor to row;col (1-based)
export CURSOR_POSITION='\033[%d;%dH'
