{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    videoDrivers = [ "intel" ];
    deviceSection = ''
    Option "DRI" "1"
    '';
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

