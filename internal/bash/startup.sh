#!/usr/bin/env bash

# Get the current time in nanoseconds
__startup_now_nano() {
  date '+%s.%N'
}

# Save the unix timestamp of startup to a global variable.
__startup_init() {
  # Use nanoseconds for precision
  export __STARTUP_UNIX_TIME="$(__startup_now_nano)"
}

# Checks if should hide the startup message.
__startup_should_display() {
  # If the user has set DOTFILES_NO_STARTUP_MESSAGE, skip the startup message
  [[ "$DOTFILES_NO_STARTUP_MESSAGE" == "" ]] || return 1

  # If the terminal is not interactive, skip the startup message
  __isinteractive_is_interactive || return 1

  # Otherwise, show the startup message
  return 0
}

# Retrieve the system information and build the line shown on success startup message
#
# It shows:
# - Hostname (e.g., "notebook")
# - Date time (e.g., "2024-03-20 09:02:07")
# - Shell name (e.g., "bash", "zsh")
# - System information (e.g., "Linux 5.4.0-42-generic")
# - Allocated RAM and CPU cores (e.g., "8GB RAM, 4 cores")
# - Whether the terminal is accessed via SSH
#
# Example:
# "notebook - bash - Ubuntu 20.04 LTS - 8GB RAM; 4 cores - SSH"
__startup_info() {
  __startup_should_display || return 0

  # Hostname
  local hostname="$(hostname -s 2>/dev/null || echo "unknown")"

  # Shell name
  local shell_name="$(ps -p $$ -o comm= | awk -F/ '{print $NF}')"

  # System information (try lsb_release, else fallback to uname)
  local sys_info=""
  if command -v lsb_release &>/dev/null; then
    sys_info="$(lsb_release -ds 2>/dev/null || true)"
  fi
  if [[ -z "$sys_info" ]]; then
    sys_info="$(uname -srm)"
  fi

  # RAM (in GB)
  local ram_gb="$(awk '/MemTotal/ {printf "%.0f", $2/1024/1024}' /proc/meminfo 2>/dev/null)"
  [[ -z "$ram_gb" ]] && ram_gb="?"
  local ram_str="${ram_gb}GB RAM"

  # CPU cores
  local cpu_cores="$(getconf _NPROCESSORS_ONLN 2>/dev/null)"
  [[ -z "$cpu_cores" ]] && cpu_cores="?"
  local cpu_str="${cpu_cores} cores"

  local result="$hostname - $shell_name - $sys_info - $ram_str; $cpu_str"

  # SSH info
  [[ -n "$SSH_CLIENT" || -n "$SSH_TTY" ]] && result+=" - SSH"

  echo "$result"
}

# Print a startup message with the current time and the time since the last startup.
__startup_message() {
  __startup_should_display || return 0

  local autoload_files=("$@")
  local files_count="${#autoload_files[@]}"
  local took=$(awk "BEGIN {print $(__startup_now_nano) - $__STARTUP_UNIX_TIME}")

  echo -ne "$LINE_START$CLEAR_LINE"
  echo -ne "${LBLACK}$(__startup_info)${RESET}"
  echo -e "\t${GRAY}Loaded $files_count files in ${took}s"
  echo -e "\t${LBLACK}$(uptime -p)"
}
