{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.foot ];
  environment.etc."config/foot/foot.ini".source = ./foot.ini;
}
