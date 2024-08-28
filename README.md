# NixOS Setup

## Requirements

- Download [NixOS ISO][nixos]

## NixOS Installation

1. Use GUI installer
1. Clone repo into `~/dev/`

    ```shell
    git clone https://github.com/thled/nix-config.git
    ```

1. Link configuration

    ```shell
    rm -rf /etc/nixos
    sudo ln -s ~/dev/nix-config /etc/nixos
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
- Connect bluetooth devices (e.g. headset) with `bluetoothctl`.
- Clone Obsidian Vault `git clone git@github.com:thled/references.git` into `~/dev/references`.
- Put OpenVPN configuration for office into `~/office.ovpn`.
- Put encryption key for atuin into `~/.atuin-key`.
- Put licence key for intelephense into `~/intelephense/licence.txt`.
- Configure k8s in `~/.kube/config`.

## Usage

- Start terminal with <kbd>Win</kbd>+<kbd>Return</kbd>.
- Start any application with <kbd>Win</kbd>+<kbd>p</kbd>.
- Use VPN with `sudo systemctl start openvpn-officeVPN.service`.
- Manage NixOS configuration in `~/dev/nix-config`.
- Update with `just update`.
- Apply updates with `just build`.

[nixos]: https://nixos.org/download.html#nixos-iso

