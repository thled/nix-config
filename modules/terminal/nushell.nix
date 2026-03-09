{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [nushell];
    etc = {
      "config/nushell/env.nu".source = ./env.nu;
      "config/nushell/config.nu".source = ./config.nu;
      "config/nushell/todo.nu".source = ./todo.nu;
    };
  };

  systemd.tmpfiles.rules = [
    "d /etc/config/nushell 0755 thled users -"
  ];
}
