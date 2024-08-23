#!/bin/bash

# File locations
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HELPER_DIR="$BASE_DIR/TimerHelper"
tracker_file="$HELPER_DIR/active_timers.txt"

# Usage instructions text
help_text="Create Timer: timer <numMins>, timer -c <numMins>\nRemove Timer: timer -r <timerNum>\nList Timers: timer -l\n"

# Check if tracker file exists / create if not
if [[ ! -e  $tracker_file ]]; then
  touch "$tracker_file"
fi

# Checks if arg is int
is_uint() {
  case $1 in
    '' | *[!0-9]*) return 1;;
    *) return 0;;
  esac ;
}

process_input() {
  # If no args, print help
  if [ $# -eq 0 ]; then
    echo Command not found. Run $0 -h for a command list.
    exit 1
  fi

  # Creates timer if arg is a number 
  is_uint "$1"
  if [ $? -eq 0 ]; then
    (sh "$HELPER_DIR/create_timer.sh" "$1")
    return 0
  fi

  # Process command opts 
  case "$1" in 
    # Create timer
    -c)
      if [ $# -eq 1 ]; then
        echo "Usage: $0 $1 <numMins>"
        exit 1
      fi
      (sh "$HELPER_DIR/create_timer.sh" "$2")
      ;;
    # List timers
    -l)
      sh "$HELPER_DIR/list_timers.sh"
      ;;
    # Remove timer
    -r)
      if [ $# -eq 1 ]; then
        echo "Usage: $0 $1 <timerNum>"
        exit 1
      fi
      sh "$HELPER_DIR/remove_timer.sh" "$2"
      ;;
    # Print help
    -h)
      printf "$help_text"
      ;;
    *)
      echo "Command not found. Run $0 -h for a command list."
      ;;
  esac
}
process_input "$@"
exit 0
