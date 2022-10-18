{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    arandr
    chromium
    cmus
    discord
    firefox
    gimp
    meld
    obs-studio
    obsidian
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

  programs.noisetorch.enable = true;

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };
}

