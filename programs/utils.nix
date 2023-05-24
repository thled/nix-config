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
    libnotify
    lsof
    nmap
    nodejs
    ntfs3g
    patchelf
    tldr
    tree
    unar
    unzip
    watchexec
    xsel
    zoxide
  ];
}

