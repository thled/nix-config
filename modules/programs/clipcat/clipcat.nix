{ pkgs, ... }: {
  # environment.systemPackages = with pkgs; [ clipcat dmenu ];

  environment.etc."config/clipcat/clipcatd.toml".source = ./clipcatd.toml;
  environment.etc."config/clipcat/clipcatctl.toml".source = ./clipcatctl.toml;
  environment.etc."config/clipcat/clipcat-menu.toml".source = ./clipcat-menu.toml;

  # systemd.services.clipcatd = {
  #   description = "Clipcat Daemon";
  #   after = [ "display-manager.service" ];
  #   requires = [ "display-manager.service" ];
  #   wantedBy = [ "multi-user.target" ];
  #   serviceConfig = {
  #     ExecStart = "${pkgs.clipcat}/bin/clipcatd --no-daemon";
  #     Restart = "always";
  #     User = "thled";
  #     Group = "users";
  #     Environment = "XDG_CONFIG_HOME=/etc/config DISPLAY=:0";
  #   };
  # };
}

