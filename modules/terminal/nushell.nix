{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [ nushell ];
    etc."config/nushell/env.nu".source = ./env.nu;
    etc."config/nushell/config.nu".source = ./config.nu;
  };
}

