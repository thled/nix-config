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

## After installation

- `sudo chown -R thled /etc/nixos/nix-config`
- `git remote set-url origin git@github.com:thled/nix-config.git` Change remote from HTTPS to SSH.

## After installation (optional)

- Sync Firefox config and addons by logging in.
- Add SSH keys to `~/.ssh/`.
- Create `~/projects` and `~/work` folder for personal and work related projects, respectively.
- Create `~/screenshots` folder for taking screenshots with <kbd>Win</kbd>+<kbd>s</kbd>.
- For fast capture to inbox with the `i` function (see [fish alias][fish]) write recipient email into `~/.inbox_email` and password for SMTP into `~/.inbox_pass`.
- Connect bluetooth devices (e.g. headset) with `bluetoothctl`.
- Obsidian Vault: `git clone git@github.com:thled/references.git`
- Copy OpenVPN configuration file for office into `/etc/nixos/nix-config/network/office.ovpn`.
- Put licence key for intelephense into `~/intelephense/licence.txt`.
- Configure k8s in `~/.kube/config`.

## Usage

- Start terminal with <kbd>Win</kbd>+<kbd>Shift</kbd>+<kbd>Return</kbd>.
- Start any application with <kbd>Win</kbd>+<kbd>p</kbd>.
- Use VPN with `sudo systemctl start openvpn-protonVPN.service`.
- Manage NixOS configuration in `/etc/nixos/nix-config`.

[nixos]: https://nixos.org/download.html#nixos-iso
[fish]: terminal/fish.nix

