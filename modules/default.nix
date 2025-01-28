{ ... }: {
  imports = [
    ./system/user.nix
    ./system/common.nix
    ./network/networkmanager.nix
    ./wm/ddcutil.nix
    ./wm/brightness-toggle.nix
    ./wm/sway.nix
    ./audio/pipewire.nix
    ./terminal/fish.nix
    # ./terminal/foot.nix
    ./terminal/ghostty.nix
    ./terminal/nushell.nix
    ./terminal/starship.nix
    ./terminal/direnv.nix
    ./editor/lsp.nix
    ./editor/vim.nix
    ./editor/helix.nix
    ./virtualisation/docker.nix
    # ./virtualisation/podman.nix
    ./virtualisation/virt_manager.nix
    ./network/vpn.nix
    ./programs/utils.nix
    ./programs/git.nix
    ./programs/kubernetes.nix
    ./programs/mako.nix
    ./programs/pwa.nix
    ./programs/ripgrep.nix
    ./programs/satty.nix
    # ./programs/syncthing.nix
    ./programs/apps.nix
  ];

  nix.settings.accept-flake-config = true;
}

