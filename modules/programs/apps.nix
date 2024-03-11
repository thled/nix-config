{ pkgs, ... }: {
  # nixpkgs.config.permittedInsecurePackages = [
  #   "electron-25.9.0" # for obsidian
  # ];
  
  environment.systemPackages = with pkgs; [
    dbeaver
    chromium
    discord
    firefox
    floorp
    gimp
    meld
    obs-studio
    obsidian
    satty
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

