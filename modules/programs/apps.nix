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

        ExtensionSettings = {
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
            installation_mode = "force_installed";
          };
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
          "addon@darkreader.org" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
            installation_mode = "force_installed";
          };
          "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
            installation_mode = "force_installed";
          };
        };
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
