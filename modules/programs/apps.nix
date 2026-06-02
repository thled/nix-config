{
  pkgs,
  # master,
  zen-browser,
  ...
}: {
  environment.systemPackages = with pkgs; [
    chromium
    claude-code
    codex
    dbeaver-bin
    gimp
    (pkgs.callPackage ./heidisql.nix {})
    meld
    mpv
    obsidian
    obs-studio
    (pkgs.callPackage ./mindwtr.nix {})
    vesktop
    zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
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
        "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
        # "nngceckbapebfimnlniiiahkandclblb" # bitwarden
        # "eimadpbcbfnmbkopoojfekhnkhdbieeh" # dark reader
        # "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      ];
      extraOpts = {
        "BrowserSignin" = 0;
        "SyncDisabled" = true;
      };
    };
  };
}
