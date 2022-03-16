{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    arandr
    chromium
    cmus
    firefox
    gimp
    meld
    noisetorch
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
}

