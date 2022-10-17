{ pkgs, lib, ... }: {
  nixpkgs.overlays = [
    (self: super: {
      leftwm = super.leftwm.overrideAttrs (oldAttrs: rec {
        version = "0.4.0";

        src = super.fetchFromGitHub {
          owner = "thled";
          repo = "leftwm";
          rev = "4b284181d9666a0cbf39ddb921ca78e9f43821de";
          sha256 = "sha256-UQiQe9hDc5dLU2+uQol6yWKpMz0N+tQUJ3hZqtXnhxM=";
        };

        cargoDeps = oldAttrs.cargoDeps.overrideAttrs (lib.const {
          name = "leftwm-0.4.0-vendor.tar.gz";
          inherit src;
          outputHash = "sha256-D00IFTELRlqeKQ7zheJKTvu5FBgYQXsZ+OnPnVzweC4=";
        });

        postInstall = ''
          for p in $out/bin/left*; do
            patchelf --set-rpath "${super.lib.makeLibraryPath [super.pkgs.xorg.libXinerama super.pkgs.xorg.libX11]}" $p
          done
        '';
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
      startx.enable = true;
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

  environment.etc."config/leftwm/config.ron".source = ./leftwm.ron;
  environment.etc."config/leftwm/themes/current".source = ./thledbar;

  programs.slock.enable = true;
  services.picom.enable = true;
  environment.systemPackages = with pkgs; [
    dmenu
    (pkgs.callPackage ./thledbar.nix { })
  ];
}

