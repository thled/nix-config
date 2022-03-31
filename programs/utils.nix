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
    nmap
    nodejs
    ntfs3g
    tldr
    tree
    unzip
    xsel
    zoxide
  ];
}

