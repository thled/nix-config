{ pkgs, statix, ... }: {
  environment.systemPackages = with pkgs; [
    bat
    calc
    cliphist
    difftastic
    eza
    fd
    ffmpeg
    fzf
    gcc
    gnumake
    imv
    jq
    just
    libnotify
    lsof
    neofetch
    nmap
    mycli
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

