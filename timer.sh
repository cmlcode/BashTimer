#!/bin/bash

# Check if the user provided the time in minutes
if [ $# -eq 0 ]; then
  echo "Usage: $0 <numMins>"
  exit 1
fi

# Get num minutes from the argument
num_mins=$1
# Convert minutes to seconds
wait_time=$((num_mins * 60))
# Sleep for specified duration
sleep $wait_time
kdialog --title "Timer completed" --passivepopup "Time up!"
paplay ~/.sound/ding.wav
exit 0
