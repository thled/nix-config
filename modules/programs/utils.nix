{ pkgs, statix, ... }: {
  environment.systemPackages = with pkgs; [
    atuin
    bat
    calc
    cliphist
    difftastic
    eza
    fd
    feh
    ffmpeg
    fzf
    gcc
    gnumake
    jq
    just
    libnotify
    lsof
    mako
    neofetch
    nmap
    mycli
    nodejs
    ntfs3g
    statix.packages."${pkgs.system}".statix
    tldr
    tree
    unar
    unzip
    watchexec
    zoxide
  ];
}

