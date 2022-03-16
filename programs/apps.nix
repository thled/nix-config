{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    arandr
    chromium
    cmus
    firefox
    gimp
    meld
    obs-studio
    vlc
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

  programs.noisetorch = {
      enable = true;
  };
}

