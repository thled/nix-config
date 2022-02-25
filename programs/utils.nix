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
    tldr
    tree
    unzip
    xsel
  ];
}

