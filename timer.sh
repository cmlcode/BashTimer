#!/bin/bash

tracker_file="$(pwd)/.active_timers.txt"
help_text="Help text"
is_uint() {
  case $1 in
    '' | *[!0-9]*) return 1;;
    *) return 0;;
  esac ;
}
process_input() {
  if [ $# -eq 0 ]; then
    echo help_text
    exit 1
  fi
  # Check if val is a num
  is_uint "$1"
  if [ $? -eq 0 ]; then
    (sh ./create_timer.sh "$1")
    return 0
  fi
  # Check what command is being run
  case "$1" in 
    -c)
      (sh ./create_timer.sh "$2")
      ;;
    -l)
      sh ./list_timers.sh
      ;;
  esac
}
process_input "$@"
exit 0
