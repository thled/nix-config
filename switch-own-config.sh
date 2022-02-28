#!/usr/bin/env bash

set -e

function log {
  local LINE="[nixos-install] $*"
  echo "$LINE"
  echo "${LINE//?/-}"
}

log "Add unstable channel"
nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
nix-channel --update

log "Add own configuration"
sed -i '/hardware-configuration/a \.\/nix-config\/my\.nix' /etc/nixos/configuration.nix

log "Switch to own configuration"
nixos-rebuild switch

log "Finished"
set +e

