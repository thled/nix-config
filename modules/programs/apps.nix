{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    dbeaver
    chromium
    gimp
    meld
    mpv
    obs-studio
    obsidian
    vesktop
    zoom-us
  ];

  programs.firefox = {
    enable = true;
  };

  programs.chromium = {
    enable = true;
    extensions = [
      # "bnjjngeaknajbdcgpfkgnonkmififhfo" # fake filler
      "fmkadmapgofadopljbjfkapdkoienihi" # react dev tools
      # "lmhkpmbekcpmknklioeibfkpmmfibljd" # redux dev tools
      "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
      # "nngceckbapebfimnlniiiahkandclblb" # bitwarden
      # "eimadpbcbfnmbkopoojfekhnkhdbieeh" # dark reader
      # "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      # "bcjindcccaagfpapjjmafapmmgkkhgoa" # JSON formatter
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

