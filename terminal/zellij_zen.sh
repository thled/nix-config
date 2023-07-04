#!/usr/bin/env sh

pane_names=$(zellij action query-pane-names)
pane_count=$(echo "$pane_names" | wc -l)

if [ "$pane_count" -eq 2 ]; then
  zellij action new-pane --direction right
  zellij action new-pane --direction right
  zellij action move-focus left
  zellij action move-focus left
  zellij action new-pane --direction right
  zellij action move-pane left
  zellij action move-focus right
  zellij action move-focus right
  zellij action close-pane
fi

if [ "$pane_count" -eq 4 ]; then
  zellij action move-focus left
  zellij action close-pane
  zellij action move-focus right
  zellij action close-pane
  exit
fi
