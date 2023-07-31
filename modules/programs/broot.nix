{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.broot ];

  environment.etc."config/broot".source = ./broot;
}
