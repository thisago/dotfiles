#!/usr/bin/env bash

# If non-interactive shell, return
__isinteractive_is_interactive || return

# Git Integration

# Map of the git statuses and it's icon and color
declare -A GIT_STATUS_COLORS=(
  # Ongoing operations
  ["REBASE"]="${YELLOW}REBASE"
  ["REBASE_CONFLICT"]="${RED}"

  # Worktree status
  ["UNSTAGED_CHANGES"]="${LYELLOW}󱇨"
  ["STAGED_CHANGES"]="${GREEN}"
  ["UNTRACKED_FILES"]="${BLUE}"

  # Situation on the upstream
  ["AHEAD_UPSTREAM"]="${GREEN}󱓊"
  ["BEHIND_UPSTREAM"]="${RED}󱓋$"
  ["DIVERGED_UPSTREAM"]="${RED}󱓌"
  ["UP_TO_DATE"]="${GREEN}󰘬"
  ["NO_UPSTREAM"]="${WHITE}󰘬"

  # Others
  ["NOT_A_GIT_REPO"]="."
)

# Function to get the current git branch
__prompt_git_current_branch() {
  git rev-parse --abbrev-ref HEAD 2>/dev/null || echo ""
}

# Function to get the number of commits in the current branch
__prompt_git_commit_count() {
  git rev-list --count HEAD 2>/dev/null || echo 0
}

# Function to get the git status
#
# It returns the branch status/ongoing operations and the situation on the upstream.
__prompt_git_status_codes() {
  local status="$(git status --ahead-behind 2>/dev/stdout)"
  if [[ "$status" == *"not a git repository"* ]]; then
    echo "NOT_A_GIT_REPO"
    return
  fi

  local output=()

  # Identify branch status
  case "$status" in
    *"interactive rebase in progress"*) output+=("REBASE") ;;
    *"You have unmerged paths"*) output+=("MERGE_CONFLICT") ;;
    *"Changes not staged for commit"*) output+=("UNSTAGED_CHANGES") ;;
    *"Changes to be committed"*) output+=("STAGED_CHANGES") ;;
    *"Untracked files"*) output+=("UNTRACKED_FILES") ;;
  esac

  # Check the branch situation on the upstream
  case "$status" in
    *"Your branch is up to date with"*) output+=("UP_TO_DATE") ;;
    *"Your branch is ahead of"*) output+=("AHEAD_UPSTREAM") ;;
    *"Your branch is behind"*) output+=("BEHIND_UPSTREAM") ;;
    *"refer to different commits"* | *"have diverged"*) output+=("DIVERGED_UPSTREAM") ;;
    *"You have unmerged paths"*) output+=("CONFLICT") ;;
    *) output+=("NO_UPSTREAM") ;;
  esac

  echo "${output[*]}"
}

# Function to mount Git status in the prompt
# It builds the prompt with the current git branch, number of commits, and the git status codes.
#
# @param statuses - The git status codes returned by __prompt_git_status_codes
# @param branch - The current git branch returned by __prompt_git_current_branch
# @param commit_count - The number of commits in the current branch returned by __prompt_git_commit_count
# @return - A string with the git status information formatted for the prompt: "<status> <branch> <commit_count>"
__prompt_git_status() {
  local statuses="$1"
  local branch="$2"
  local commit_count="$3"

  # If there is no git repository, return an empty string
  if [[ -z "$branch" ]]; then
    echo -n ""
    return
  fi

  local output=""
  local status_codes=()

  # Add the branch name
  IFS=' ' read -r -a status_codes <<< "$statuses"
  for status_code in ${status_codes[@]}; do
    output+=" ${GIT_STATUS_COLORS[$status_code]}"
  done
  output+=" $branch$RESET "

  # Add the number of commits
  output+="${YELLOW} ${commit_count}${RESET}"

  echo -n "$output"
}

# Function to determine the prompt character based on the user
__prompt_prompt_char() {
  local user="$1"
  if [[ "$user" == "root" ]]; then
    echo "#"
  else
    echo "$"
  fi
}

# Function to get the exit status of the last command
__prompt_status_code() {
  local status_code=0

  # Check the exit status of the last command
  if [[ "$_ble_edit_exec_PIPESTATUS" != "" ]]; then
    status_code="$_ble_edit_exec_PIPESTATUS"
  elif [[ "$?" != "0" ]]; then
    status_code="$?"
  fi

  echo -n "$status_code"
}

# Template buffer for the prompt
__prompt_prompt_command() {
  # Get the terminal cols
  local cols=$(tput cols)

  # Save the parameters
  local cwd='\w'

  # If the expanded cwd is longer than 1/2 of the terminal width, truncate it
  if [[ ${#PWD} -gt $((cols / 2)) ]]; then
    cwd="$(basename "$PWD")"
  fi


  local dt="$(date +'%H%M%S')"
  local status="$(__prompt_status_code)"

  # Build the prompt
  local prompt=""

  # Get $ or # based on the user
  local prompt_char="$(__prompt_prompt_char "$user")"

  # Current working directory
  prompt+="$GRAY$cwd "

  # Date and Time
  prompt+="$LBLACK$dt"


  # Git branch and status
  git_branch="$(__prompt_git_current_branch)"
  # If the git branch is larger than 1/3 of the terminal width, cut it
  if [[ ${#git_branch} -gt $((cols / 3)) ]]; then
    git_branch="${git_branch:0:$((cols / 3 - 3))}…"
  fi

  # Add the git status to the prompt
  prompt+="$(__prompt_git_status \
    "$(__prompt_git_status_codes)" \
    "$git_branch" \
    "$(__prompt_git_commit_count)")"

  prompt+=" "

  # Exit status of the last command
  if [[ $status -ne 0 ]]; then
    prompt+="$RED$status$OFF "
  else
    prompt+="$GREEN$status$OFF "
  fi

  # If prompt exceeds terminal width, truncate it
  if [[ ${#prompt} -gt $cols ]]; then
    prompt+="\n"
  fi

  # Add the prompt character
  prompt+="${GRAY}${prompt_char}${RESET} "

  # Set the PS1 variable to the built prompt
  PS1="$prompt"
}

# Register the prompt command to be called before each prompt
PROMPT_COMMAND="history -a; __prompt_prompt_command"
