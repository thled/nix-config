{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    bat
    direnv
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
    ntfs3g
    tldr
    tree
    unzip
    xsel
    zoxide
  ];
}

