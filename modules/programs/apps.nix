{
  pkgs,
  # master,
  zen-browser,
  ...
}:
let
  zen-browser-package =
    zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
      extraPolicies = {
        DisableAppUpdate = true;
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DontCheckDefaultBrowser = true;
        PasswordManagerEnabled = false;
        OfferToSaveLogins = false;
        AutofillCreditCardEnabled = false;
        DisableFeedbackCommands = true;
      };
    };
in {
  environment.systemPackages = with pkgs; [
    chromium
    claude-code
    codex
    dbeaver-bin
    gimp
    meld
    mpv
    obsidian
    obs-studio
    vesktop
    zen-browser-package
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
