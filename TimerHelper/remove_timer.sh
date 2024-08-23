#!/bin/bash
tracker_file="$HOME/.config/BashTimer/active_timers.txt"
timer_num="$1"

if [ -z "$timer_num" ]; then
  exit 1
fi

if [ ! -f "$tracker_file" ]; then
 exit 1
fi

# Timers are 0-indexed, but awk is 1-indexed
line_num=$((timer_num + 1))
# Remove line from tracker file
sed -i "${line_num}d" "$tracker_file"
