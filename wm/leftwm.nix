{ pkgs, lib, ... }: {
  nixpkgs.overlays = [
    (self: super: {
      leftwm = super.leftwm.overrideAttrs (oldAttrs: rec {
        version = "0.4.0";

        src = super.fetchFromGitHub {
          owner = "leftwm";
          repo = "leftwm";
          rev = "360834f42734125758905059f2aedb6316d176ac";
          sha256 = "sha256-mjFRGMQNTTw9G2X81EjamLL3dwMGU56t95Ao4uCAUoc=";
        };

        cargoDeps = oldAttrs.cargoDeps.overrideAttrs (lib.const {
          name = "leftwm-0.4.0-vendor.tar.gz";
          inherit src;
          outputHash = "sha256-XJdnjfeLMwdgfwegkzJY/ksWLylKS8pse2/Xs7XTtrU=";
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
  environment.etc."config/uair/uair.toml".source = ./uair.toml;

  programs.slock.enable = true;
  services.picom.enable = true;
  environment.systemPackages = with pkgs; [
    j4-dmenu-desktop
    (pkgs.callPackage ./thledbar.nix { })
    (pkgs.callPackage ./uair.nix { })
  ];
}

