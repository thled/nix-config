{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [nushell];
    etc = {
      "config/nushell/env.nu".source = ./env.nu;
      "config/nushell/config.nu".source = ./config.nu;
      "config/nushell/todo.nu".source = ./todo.nu;
    };
  };
}
