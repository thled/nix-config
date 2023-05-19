#!/usr/bin/env sh

exit=false

for arg in "$@"
do
  if [ "$arg" == "--exit" ]; then
    exit=true
    set -- "${@//--exit/}"
    break
  fi
done

if [ "$exit" = true ]; then
  zellij action move-focus left
  zellij action close-pane
  zellij action move-focus right
  zellij action close-pane
  exit
fi

zellij action new-pane --direction right
zellij action new-pane --direction right
zellij action move-focus left
zellij action move-focus left
zellij action new-pane --direction right
zellij action move-pane left
zellij action move-focus right
zellij action move-focus right
zellij action close-pane