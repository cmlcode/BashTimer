#!/bin/bash

tracker_file="$(pwd)/.active_timers.txt"

is_uint() {
  case $1 in
    '' | *[!0-9]*) return 1;;
    *) return 0;;
  esac ;
}
get_input() {
# Check if val is a num
  is_uint "$1"
  if [ $? -eq 0 ]; then
    echo "I run"
    (sh ./create_timer.sh "$1")
  else
    echo "Input is not an unsigned int"
  fi
}
exit 0
