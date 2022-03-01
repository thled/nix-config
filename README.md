# NixOS Setup

## Table of Contents

1. [Requirements](#requirements)
1. [NixOS Installation (Script)](#nixos-installation-script)
1. [NixOS Installation (Manually)](#nixos-installation-manually)
1. [After installation (optional)](#after-installation-optional)
1. [Usage](#usage)

## Requirements

- Download [NixOS ISO][nixos]

## NixOS Installation (Script)

1. Change to root user

    ```shell
    sudo -i
    ```

1. Download nixos install script

    ```shell
    curl -LO https://raw.githubusercontent.com/thled/nix-config/master/nixos-install.sh
    ```

1. Run nixos install script

    ```shell
    bash nixos-install.sh
    ```

1. Reboot and login as root
1. Clone own configuration

    ```shell
    nix-shell -p git --run "git clone https://github.com/thled/nix-config.git /etc/nixos/nix-config"
    ```

1. Switch to own configuration

    ```shell
    bash /etc/nixos/nix-config/switch-own-config.sh
    ```

1. Reboot

    ```shell
    reboot
    ```

1. Change initial password (`123`)

    ```shell
    passwd
    ```

## NixOS Installation (Manually)

1. Change to root user

    ```shell
    sudo -i
    ```

1. Verify UEFI

    ```shell
    ls /sys/firmware/efi/efivars
    ```

1. Verify internet

    ```shell
    ping -c3 google.com
    ```

1. Partitioning
    1. Create a GPT partition table

        ```shell
        parted /dev/sda -- mklabel gpt
        ```

    1. Add the root partition

        ```shell
        parted /dev/sda -- mkpart primary 512MiB -8GiB
        ```

    1. Add the swap partition

        ```shell
        parted /dev/sda -- mkpart primary linux-swap -8GiB 100%
        ```

    1. Add the boot partition

        ```shell
        parted /dev/sda -- mkpart ESP fat32 1MiB 512MiB
        parted /dev/sda -- set 3 esp on
        ```

1. Formatting
    1. Create root partition

        ```shell
        cryptsetup luksFormat /dev/sda1
        cryptsetup luksOpen /dev/sda1 cryptroot
        mkfs.ext4 -L nixos /dev/mapper/cryptroot
        ```

    1. Create swap partition

        ```shell
        mkswap -L swap /dev/sda2
        ```

    1. Create boot partition

        ```shell
        mkfs.fat -F 32 -n boot /dev/sda3
        ```

1. Mounting
    1. Mount root partition

        ```shell
        mount /dev/disk/by-label/nixos /mnt
        ```

    1. Mount boot partition

        ```shell
        mkdir /mnt/boot
        mount /dev/disk/by-label/boot /mnt/boot
        ```

    1. Activate swap

        ```shell
        swapon /dev/sda2
        ```

1. Installing
    1. Create configuration

        ```shell
        nixos-generate-config --root /mnt
        ```

    1. Install

        ```shell
        nixos-install
        ```
            
    1. Reboot system

        ```shell
        reboot
        ```

    1. Copy own configuration

        ```shell
        nix-shell -p git --run "git clone https://github.com/thled/nix-config.git /etc/nixos/nix-config"
        ```

    1. Add own configuration (`./nix-config/my.nix` in imports list)

        ```shell
        sudoedit /etc/nixos/configuration.nix
        ```

    1. Add unstable channel

        ```shell
        nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
        nix-channel --update
        ```

    1. Switch to own configuration

        ```shell
        nixos-rebuild switch
        ```

    1. Reboot system

        ```shell
        reboot
        ```

    1. Change initial password (`123`)

        ```shell
        passwd
        ```

## After installation (optional)

- Sync Firefox config and addons by logging in.
- Add SSH keys to `~/.ssh/`.
- Create `~/projects` and `~/work` folder for private and work related projects, respectivly.
- Connect bluetooth headset with `bluetoothctl`.

## Usage

- Start terminal with <kbd>Win</kbd>+<kbd>Shift</kbd>+<kbd>Return</kbd>.
- Start any application with <kbd>Win</kbd>+<kbd>p</kbd>.
- Use VPN with `systemctl start openvpn-protonVPN.service`.
- Use office VPN with `nmcli connection up office --ask`.
- Manage NixOS configuration in `/etc/nixos/nix-config`.

[nixos]: https://nixos.org/download.html#nixos-iso

