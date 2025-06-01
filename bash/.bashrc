#!/usr/bin/env bash

# Store the start unix time
LOAD_START_TIME=$(date '+%s')

# Export 'SHELL' to child processes.
# Programs such as 'screen' honor it and otherwise use /bin/sh.
export SHELL

if [[ $- != *i* ]] || [[ $TERM == "dumb" ]]; then
  [[ -n "$SSH_CLIENT" ]] && source /etc/profile
fi

dir="$(dirname "$(realpath ~/.bashrc)")"
for file in `ls $dir/internal/*.sh`; do
  # Show a loading on the same line, replacing the previous one
  echo -ne "\r\033[KLoading $(basename "$file")..."
  source "$file"
done

# After loading all files, show some infos

# Function to display terminal information
#
# It shows:
# - Date time (e.g., "2024-03-20 09:02:07")
# - Shell name (e.g., "bash", "zsh")
# - System information (e.g., "Linux 5.4.0-42-generic")
# - Allocated RAM and CPU cores (e.g., "8GB RAM, 4 cores")
# - Whether the terminal is accessed via SSH
#
# Example:
# "2024-03-20 09:02:07 - bash - Ubuntu 20.04 LTS - 8GB RAM; 4 cores - SSH"
function terminal_info() {
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

  echo "$datetime - $shell_name - $sys_info - $ram_str; $cpu_str$ssh_str"
}

# Calculate the seconds in float of the startup time, e.g., 2.324
LOAD_END_TIME="$(date '+%s.%N')"
LOAD_TOOK_SECONDS=$(awk "BEGIN {print $LOAD_END_TIME - $LOAD_START_TIME}")

# Show a newline after loading all files
INFO="${LGRAY}Loaded in ${LOAD_TOOK_SECONDS}s\t$LBLACK$(terminal_info)$RESET"
echo -e "$LINE_START$INFO"
