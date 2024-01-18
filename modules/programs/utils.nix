{ pkgs, statix, ... }: {
  environment.systemPackages = with pkgs; [
    bat
    calc
    difftastic
    dunst
    eza
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
    mpv
    mycli
    nmap
    nodejs
    ntfs3g
    statix.packages."${pkgs.system}".statix
    tldr
    tree
    unar
    unzip
    watchexec
    xsel
    zoxide
  ];
}

