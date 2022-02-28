#!/usr/bin/env bash

set -e

function log {
  local LINE="[nixos-install] $*"
  echo "$LINE"
  echo "${LINE//?/-}"
}

function ask {
  read -p "$1> "
  eval "export $2=\$REPLY"
}

log "Setup questions:"
ask 'Device' __DEVICE__
ask 'Encryption password' __ENCRYPTION__

log "Verify UEFI"
ls /sys/firmware/efi/efivars

log "Verify internet"
ping -c 3 google.com

log "Partitioning"
parted /dev/${__DEVICE__} -- mklabel gpt
parted /dev/${__DEVICE__} -- mkpart primary 512MiB -8GiB
parted /dev/${__DEVICE__} -- mkpart primary linux-swap -8GiB 100%
parted /dev/${__DEVICE__} -- mkpart ESP fat32 1MiB 512MiB
parted /dev/${__DEVICE__} -- set 3 esp on

log "Formatting"
echo -n "${__ENCRYPTION__}" | cryptsetup luksFormat /dev/${__DEVICE__}1 -
echo -n "${__ENCRYPTION__}" | cryptsetup luksOpen /dev/${__DEVICE__}1 cryptroot -
mkfs.ext4 -L nixos /dev/mapper/cryptroot
mkswap -L swap /dev/${__DEVICE__}2
mkfs.fat -F 32 -n boot /dev/${__DEVICE__}3

log "Mounting"
mount /dev/disk/by-label/nixos /mnt
mkdir /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
swapon /dev/${__DEVICE__}2

log "Installing"
nixos-generate-config --root /mnt
nixos-install

log "Finished"
set +e

