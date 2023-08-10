{ pkgs, ... }: 
{
  environment.systemPackages = [ pkgs.zellij ];
  environment.etc."config/zellij/config.kdl".source = ./zellij.kdl;
}
