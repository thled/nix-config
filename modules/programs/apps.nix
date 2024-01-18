{ pkgs, ... }: {
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0" # for obsidian
  ];
  
  environment.systemPackages = with pkgs; [
    arandr
    dbeaver
    chromium
    discord
    firefox
    flameshot
    gimp
    meld
    obs-studio
    obsidian
    ollama
    qutebrowser
    strawberry
    vlc
    zoom-us
  ];

  programs.chromium = {
    enable = true;
    extensions = [
      "bnjjngeaknajbdcgpfkgnonkmififhfo" # fake filler
      "fmkadmapgofadopljbjfkapdkoienihi" # react dev tools
      "lmhkpmbekcpmknklioeibfkpmmfibljd" # redux dev tools
      "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
    ];
    extraOpts = {
      "BrowserSignin" = 0;
      "SyncDisabled" = true;
    };
  };

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };
}

