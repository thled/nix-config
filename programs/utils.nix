{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    bat
    clipit
    dunst
    exa
    fd
    feh
    ffmpeg
    fzf
    imagemagick
    jq
    kubectl
    nmap
    nodejs
    tldr
    tree
    unzip
    xsel
  ];
}

