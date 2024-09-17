{ pkgs, ... }: 
let
  # run at the end of sway config
  # see https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  dbus-sway-environment = pkgs.writeScriptBin "dbus-sway-environment" ''
    dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
    systemctl --user stop pipewire wireplumber pipewire-pulse xdg-desktop-portal xdg-desktop-portal-wlr
    systemctl --user start pipewire wireplumber pipewire-pulse xdg-desktop-portal xdg-desktop-portal-wlr
  '';
in
{
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [ 
      autotiling
      dbus-sway-environment
      swaylock
      swayidle
    ];
    extraSessionCommands = ''
      export NIXOS_OZONE_WL=1;
    '';
  };

  programs.waybar.enable = true;

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  environment = {
    etc."config/sway/config".source = ./sway.conf;
    etc."config/waybar/config".source = ./waybar.jsonc;
    etc."config/waybar/style.css".source = ./waybar.css;
  };
}
