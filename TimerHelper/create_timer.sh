#!/bin/bash
# File to track created timers
tracker_file="$HOME/.config/BashTimer/active_timers.txt"
# Function to remove the PID line in tracker file
cleanup() {
  sed -i "/:$PID$/d" "$tracker_file"
}
# Set trap to cleanup function no matter how scrpt exits
trap cleanup EXIT INT TERM

# Check if the user provided the time in minutes
if [ $# -eq 0 ]; then
  echo "Usage: $0 <numMins>"
  exit 1
fi

# Get num minutes from the argument
num_mins=$1
# Convert minutes to seconds
wait_time=$((num_mins * 60))
start_time=$(date +%s)

# Track the current timer
PID=$$
echo "$start_time:$wait_time:$PID">>$tracker_file
# Start the timer
sleep $wait_time
# Check that timer is still active
if grep -Fq ":$PID" "$tracker_file"; then
  kdialog --title "Timer completed" --passivepopup "Time up!"
  paplay $(dirname "$0")/ding.wav
fi
exit 0
