#!/bin/bash
tracker_file="$(dirname "$0")/.active_timers.txt"
curr_timer=0
clean_tracker_file(){
  while IFS=: read -r start_time wait_time PID; do
    if ! ps -p  ${PID} > /dev/null 2>&1; then
      # PID not found, remove from tracker_file
      sed -i "/:$PID$/d" "${tracker_file}"
    else
      curr_time=$(date +%s)
      time_left=$((wait_time - (curr_time - start_time)))
      echo "Timer ${curr_timer}: ${time_left}s"
      ((curr_timer+=1))
    fi
  done <"$tracker_file"
}

clean_tracker_file
