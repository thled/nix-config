# NixOS Setup

## NixOS Installation

1. Download [NixOS ISO][nixos].
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

    - If no internet: ToDo
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

    1. Add own configuration (`/etc/nixos/my.nix` in imports list)

        ```shell
        sudoedit /etc/nixos/configuration.nix
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

[nixos]: https://nixos.org/download.html#nixos-iso

