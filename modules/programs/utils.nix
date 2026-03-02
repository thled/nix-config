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
    gnumake
    imv
    # jless
    # (callPackage ./jless.nix { })
    jq
    just
    libnotify
    lsof
    neofetch
    nmap
    nodejs
    ntfs3g
    tldr
    tree
    unar
    unzip
    wl-clipboard
    zoxide
  ];
}
