{...}: {
  imports = [
    ./system/user.nix
    ./system/common.nix
    ./network/networkmanager.nix
    ./wm/niri.nix
    ./audio/pipewire.nix
    ./terminal/fish.nix
    ./terminal/foot.nix
    ./terminal/ghostty.nix
    ./terminal/nushell.nix
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
    ./programs/jj.nix
    ./programs/kubernetes.nix
    ./programs/mako.nix
    ./programs/mindwtr-capture.nix
    ./programs/opencode.nix
    ./programs/pwa.nix
    ./programs/ripgrep.nix
    ./programs/apps.nix
  ];

  nix.settings.accept-flake-config = true;
}
