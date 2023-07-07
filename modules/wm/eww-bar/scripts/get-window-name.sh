#!/usr/bin/env bash

extract_window_id() {
  local window=$1
  echo $window | cut -d" " -f5
}

invalid_window_id() {
  if [ "$window_id" == "0xffffffff" ]; then
    return 0
  else
    return 1
  fi
}

get_window_name() {
  local window_id=$1
  xprop -id $window_id _NET_WM_NAME | cut -d"\"" -f2
}

truncate_name() {
  local window_name=$1
  if [ ${#window_name} -gt 50 ]; then
    window_name_truncated=$(echo $window_name | head -c 50)
    window_name="${window_name_truncated}..."
  fi
  echo $window_name
}

while read window; do
  window_id=$(extract_window_id "$window")
  
  if invalid_window_id; then
    echo ""
  else
    window_name=$(get_window_name $window_id)
    truncate_name "$window_name"
  fi
done < <(xprop -spy -root _NET_ACTIVE_WINDOW)
