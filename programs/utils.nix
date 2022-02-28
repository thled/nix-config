{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    bat
    dunst
    exa
    fd
    feh
    ffmpeg
    fzf
    gcc
    imagemagick
    jless
    jq
    nmap
    nodejs
    slock
    tldr
    tree
    unzip
    xsel
    zoxide
  ];
}

