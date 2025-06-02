{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
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
    mycli
    neofetch
    nmap
    nodejs
    ntfs3g
    tldr
    tree
    unar
    unzip
    watchexec
    wl-clipboard
    yek
    zoxide
  ];
}

