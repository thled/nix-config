{ ... }: {
  imports = [
    ./system/user.nix
    ./system/common.nix
    ./network/networkmanager.nix
    ./network/mail.nix
    ./wm/hyprland.nix
    ./audio/pipewire.nix
    ./terminal/fish.nix
    ./terminal/foot.nix
    ./terminal/starship.nix
    ./terminal/direnv.nix
    ./editor/lsp.nix
    ./editor/vim.nix
    ./editor/helix.nix
    ./virtualisation/docker.nix
    ./virtualisation/virt_manager.nix
    ./network/vpn.nix
    ./programs/utils.nix
    ./programs/atuin.nix
    ./programs/git.nix
    ./programs/kubernetes.nix
    ./programs/mako.nix
    ./programs/pwa.nix
    ./programs/ripgrep.nix
    ./programs/satty.nix
    ./programs/syncthing.nix
    ./programs/apps.nix
  ];

  nix.settings.accept-flake-config = true;
}

