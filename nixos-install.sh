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

log "Verify UEFI"
ls /sys/firmware/efi/efivars

log "Verify internet"
ping -c 3 google.com

log "List devices"
lsblk

log "Setup questions:"
ask 'Device' __DEVICE__
ask 'Partition Prefix' __PARTITION__
ask 'Encryption password' __ENCRYPTION__

log "Partitioning"
parted /dev/${__DEVICE__} -- mklabel gpt
parted /dev/${__DEVICE__} -- mkpart primary 512MB -8GB
parted /dev/${__DEVICE__} -- mkpart primary linux-swap -8GB 100%
parted /dev/${__DEVICE__} -- mkpart ESP fat32 1MB 512MB
parted /dev/${__DEVICE__} -- set 3 esp on

log "Formatting"
echo -n "${__ENCRYPTION__}" | cryptsetup luksFormat /dev/${__DEVICE__}${__PARTITION__}1 -
echo -n "${__ENCRYPTION__}" | cryptsetup luksOpen /dev/${__DEVICE__}${__PARTITION__}1 cryptroot -
mkfs.ext4 -L nixos /dev/mapper/cryptroot
mkswap -L swap /dev/${__DEVICE__}${__PARTITION__}2
mkfs.fat -F 32 -n boot /dev/${__DEVICE__}${__PARTITION__}3

log "Mounting"
mount /dev/disk/by-label/nixos /mnt
mkdir /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
swapon /dev/${__DEVICE__}${__PARTITION__}2

log "Add own configuration"
nixos-generate-config --root /mnt
sed -i '/hardware-configuration/a \.\/nix-config\/my\.nix' /mnt/etc/nixos/configuration.nix
nix-shell -p git --run "git clone https://github.com/thled/nix-config.git /mnt/etc/nixos/nix-config"

log "Installing"
nixos-install

log "Finished"
set +e

