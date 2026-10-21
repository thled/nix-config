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

        Preferences = {
          "zen.glance.enabled" = {
            Value = false;
            Status = "locked";
          };
          "zen.pinned-tab-manager.restore-pinned-tabs-to-pinned-url" = {
            Value = true;
            Status = "locked";
          };
          "zen.site-data-panel.show-callout" = {
            Value = false;
            Status = "locked";
          };
          "zen.tab-unloader.excluded-urls" = {
            Value = "mail.google.com,calendar.google.com,outlook.office.com,ticktick.com";
            Status = "locked";
          };
          "zen.tabs.show-newtab-vertical" = {
            Value = false;
            Status = "locked";
          };
          "zen.tabs.vertical" = {
            Value = true;
            Status = "locked";
          };
          "zen.tabs.vertical.right-side" = {
            Value = false;
            Status = "locked";
          };
          "zen.theme.accent-color" = {
            Value = "#aac7ff";
            Status = "locked";
          };
          "zen.theme.color-prefs.use-workspace-colors" = {
            Value = false;
            Status = "locked";
          };
          "zen.view.compact.enable-at-startup" = {
            Value = false;
            Status = "locked";
          };
          "zen.view.experimental-no-window-controls" = {
            Value = true;
            Status = "locked";
          };
          "zen.view.show-newtab-button-top" = {
            Value = false;
            Status = "locked";
          };
          "zen.view.sidebar-expanded.on-hover" = {
            Value = false;
            Status = "locked";
          };
          "zen.view.use-single-toolbar" = {
            Value = true;
            Status = "locked";
          };
          "zen.urlbar.behavior" = {
            Value = "float";
            Status = "locked";
          };
          "zen.welcome-screen.seen" = {
            Value = true;
            Status = "locked";
          };
          "zen.workspaces.separate-essentials" = {
            Value = false;
            Status = "locked";
          };
          "browser.toolbars.bookmarks.visibility" = {
            Value = "never";
            Status = "locked";
          };
          "browser.translations.neverTranslateLanguages" = {
            Value = "de";
            Status = "locked";
          };
          "devtools.theme" = {
            Value = "dark";
            Status = "locked";
          };
          "devtools.toolbox.host" = {
            Value = "right";
            Status = "locked";
          };
          "layout.spellcheckDefault" = {
            Value = 0;
            Status = "locked";
          };
          "media.videocontrols.picture-in-picture.video-toggle.enabled" = {
            Value = false;
            Status = "locked";
          };
          "services.sync.engine.passwords" = {
            Value = false;
            Status = "locked";
          };
        };

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
