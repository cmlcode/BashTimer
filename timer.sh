#!/bin/bash
tracker_file="$(dirname "$0")/TimerHelper/.active_timers.txt"
help_text="Create Timer: timer <numMins>, timer -c <numMins>\nRemove Timer: timer -r <timerNum>\nList Timers: timer -l\n"
is_uint() {
  case $1 in
    '' | *[!0-9]*) return 1;;
    *) return 0;;
  esac ;
}
process_input() {
  if [ $# -eq 0 ]; then
    echo Command not found. Run $0 -h for a command list.
    exit 1
  fi
  # Check if val is a num
  is_uint "$1"
  if [ $? -eq 0 ]; then
    (sh $(dirname "$0")/TimerHelper/create_timer.sh "$1")
    return 0
  fi
  # Check what command is being run
  case "$1" in 
    -c)
      if [ $# -eq 1 ]; then
        echo "Usage: $0 $1 <numMins>"
        exit 1
      fi
      (sh $(dirname "$0")/TimerHelper/create_timer.sh "$2")
      ;;
    -l)
      sh $(dirname "$0")/TimerHelper/list_timers.sh
      ;;
    -r)
      if [ $# -eq 1 ]; then
        echo "Usage: $0 $1 <timerNum>"
        exit 1
      fi
      sh $(dirname "$0")/TimerHelper/remove_timer.sh "$2"
      ;;
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
