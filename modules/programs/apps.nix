{ pkgs, zen-browser, ... }: {
  environment.systemPackages = with pkgs; [
    dbeaver-bin
    chromium
    gimp
    meld
    mpv
    obs-studio
    obsidian
    vesktop
    # zed-editor
    zen-browser.packages.${pkgs.system}.default
    zoom-us
  ];

  programs = {
    firefox = {
      enable = true;
    };

    chromium = {
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

    wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };
  };
}

