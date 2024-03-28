{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    dbeaver
    chromium
    discord
    firefox
    floorp
    gimp
    meld
    mpv
    obs-studio
    obsidian
    vesktop
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

