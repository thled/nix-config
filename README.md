# NixOS Setup

## Table of Contents

1. [Requirements](#requirements)
1. [NixOS Installation (Script)](#nixos-installation-script)
1. [After installation (optional)](#after-installation-optional)
1. [Usage](#usage)

## Requirements

- Download [NixOS ISO][nixos]

## NixOS Installation (Script)

1. Change to root user

    ```shell
    sudo -i
    ```

1. Configure wifi

    ```shell
    ip a
    systemctl start wpa_supplicant
    wpa_cli -i <WIFI>
    > add_network
    > set_network 0 ssid "<SSID>"
    > set_network 0 psk "<PASSWORD>"
    > set_network 0 key_mgmt WPA-PSK
    > enable_network 0
    ```

1. Download nixos install script

    ```shell
    curl -LO https://raw.githubusercontent.com/thled/nix-config/master/nixos-install.sh
    ```

1. Run nixos install script

    ```shell
    bash nixos-install.sh
    ```

1. Reboot

    ```shell
    reboot
    ```

1. Change initial password (`123`)

    ```shell
    passwd
    ```

1. Configure wifi

    ```shell
    nmcli device wifi connect <SSID> --ask
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

