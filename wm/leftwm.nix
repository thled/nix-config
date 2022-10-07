{ pkgs, lib, ... }: {
  nixpkgs.overlays = [
    (self: super: {
      leftwm = super.leftwm.overrideAttrs (oldAttrs: rec {
        version = "0.3.0";

        src = super.fetchFromGitHub {
          owner = "thled";
          repo = "leftwm";
          rev = "8ac9b28c129711b0a048133a3b50c95daad70642";
          sha256 = "sha256-gzIOrvs/Z2FLEq8An3dRo/FcM3BibUJb6WDoalGKT60=";
        };

        cargoDeps = oldAttrs.cargoDeps.overrideAttrs (lib.const {
          name = "leftwm-0.3.0-vendor.tar.gz";
          inherit src;
          outputHash = "sha256-MmxF1jt5VUZGbkEe858HBjAuHhgDY23MJJxpYQ4ckhs=";
        });
      });
    })
  ];

  services.xserver = {
    enable = true;
    libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };
    xkbOptions = "compose:menu";
    windowManager.leftwm = {
      enable = true;
    };
    displayManager = {
      defaultSession = "none+leftwm";
      lightdm.enable = true;
      autoLogin = {
        enable = true;
        user = "thled";
      };
      sessionCommands = ''
        ${pkgs.xorg.xrdb}/bin/xrdb -merge <<EOF
          *background: #1E1E2E
          *foreground: #CDD6F4

          ! black
          *color0: #45475A
          *color8: #585B70

          ! red
          *color1: #F38BA8
          *color9: #F38BA8

          ! green
          *color2: #A6E3A1
          *color10: #A6E3A1

          ! yellow
          *color3: #F9E2AF
          *color11: #F9E2AF

          ! blue
          *color4: #89B4FA
          *color12: #89B4FA

          ! magenta
          *color5: #F5C2E7
          *color13: #F5C2E7

          ! cyan
          *color6: #94E2D5
          *color14: #94E2D5

          ! white
          *color7: #BAC2DE
          *color15: #A6ADC8
        EOF
      '';
    };
  };

  environment.etc."config/leftwm/config.toml".source = ./config.toml;
  environment.etc."config/leftwm/themes/current".source = ./thledbar;

  programs.slock.enable = true;
  services.picom.enable = true;
  environment.systemPackages = with pkgs; [
    dmenu
    (pkgs.callPackage ./thledbar.nix { })
  ];
}

