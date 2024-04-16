{ pkgs, ... }: {
  environment = {
    systemPackages = [ pkgs.mako ];
    etc."config/mako/config".source = ./mako.config;
  };
}
