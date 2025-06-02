#!/usr/bin/env bash

# Save the unix timestamp of startup to a global variable.
__startup_init() {
  # Use nanoseconds for precision
  export __STARTUP_UNIX_TIME="$(date '+%s.%N')"
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
# "notebook - 2024-03-20 09:02:07 - bash - Ubuntu 20.04 LTS - 8GB RAM; 4 cores - SSH"
__startup_info() {
  # Hostname
  local hostname="$(hostname -s 2>/dev/null || echo "unknown")"

  # Date time
  local datetime="$(date '+%Y-%m-%d %H:%M:%S')"

  # Shell name
  local shell_name="$(ps -p $$ -o comm= | awk -F/ '{print $NF}')"

  # System information (try lsb_release, else fallback to uname)
  local sys_info=""
  if command -v lsb_release &> /dev/null; then
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

  # SSH info
  local ssh_str=""
  [[ -n "$SSH_CLIENT" || -n "$SSH_TTY" ]] && ssh_str=" - SSH"

  echo "$hostname - $datetime - $shell_name - $sys_info - $ram_str; $cpu_str$ssh_str"
}

# Print a startup message with the current time and the time since the last startup.
__startup_message() {
  local now="$(date '+%s.%N')"
  local took="?.???"
  if [[ -n "$__STARTUP_UNIX_TIME" ]]; then
    took=$(awk "BEGIN {print $now - $__STARTUP_UNIX_TIME}")
  fi

  echo -ne "$LINE_START$CLEAR_LINE"
  echo -ne "${LBLACK}$(__startup_info)${RESET}"
  echo -e "\t${GRAY}Loaded in ${took}s"
}

# Shows on the same line a loading message
__startup_loading() {
  local pkg="$1"
  echo -ne "\r\033[KLoading $pkg..."
}
