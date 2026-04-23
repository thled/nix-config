{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    alejandra
    bat
    bibata-cursors
    calc
    cliphist
    difftastic
    dig
    fd
    ffmpeg
    file
    fuzzel
    fzf
    gcc
    gh
    gnumake
    imv
    # jless
    # (callPackage ./jless.nix { })
    jq
    just
    libnotify
    lsof
    fastfetch
    nmap
    nodejs
    ntfs3g
    python3
    satty
    tldr
    tree
    unar
    unzip
    wl-clipboard
    zoxide
  ];
}
