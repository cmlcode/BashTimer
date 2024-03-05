#!/bin/bash
# File to track created timers
tracker_file="$(dirname "$0")/.active_timers.txt"
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
if sleep $wait_time; then
  kdialog --title "Timer completed" --passivepopup "Time up!"
  paplay $(dirname "$0")/ding.wav
fi
  
# Show that timer completed normally
exit 0
