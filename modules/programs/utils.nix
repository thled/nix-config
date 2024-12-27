{ pkgs, statix, ... }: {
  environment.systemPackages = with pkgs; [
    bat
    bibata-cursors
    calc
    clipse
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
    (callPackage ./jless.nix { })
    jq
    just
    libnotify
    lsof
    mycli
    neofetch
    nmap
    nodejs
    ntfs3g
    statix.packages."${pkgs.system}".statix
    tldr
    tree
    unar
    unzip
    watchexec
    wl-clipboard
    zoxide
  ];
}

