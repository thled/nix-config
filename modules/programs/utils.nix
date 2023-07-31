{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    bat
    calc
    difftastic
    dunst
    exa
    fd
    feh
    ffmpeg
    fzf
    gcc
    gnumake
    imagemagick
    jless
    jq
    just
    libnotify
    lsof
    nmap
    mycli
    nodejs
    ntfs3g
    tldr
    tree
    unar
    unzip
    watchexec
    xsel
    zoxide
  ];
}

