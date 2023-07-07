# NixOS Setup

## Requirements

- Download [NixOS ISO][nixos]

## NixOS Installation

1. Use GUI installer
1. Clone repo
1. Link configuration

    ```shell
    rm -rf /etc/nixos
    sudo ln -s ~/dev/nixos-config /etc/nixos
    ```
1. Deploy configuration

    ```shell
    sudo nixos-rebuild switch
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
- Create `~/dev` and `~/work` folder for personal and work related projects, respectively.
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
- Manage NixOS configuration in `~/dev/nixos-config`.
- Update with `nix flake update`.

[nixos]: https://nixos.org/download.html#nixos-iso
[fish]: terminal/fish.nix

