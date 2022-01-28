{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    bat
    clipit
    dunst
    exa
    fd
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
  ];
}

