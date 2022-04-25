{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    bat
    difftastic
    direnv
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
    nmap
    nodejs
    ntfs3g
    tldr
    tree
    unar
    unzip
    xsel
    zoxide
  ];
}

