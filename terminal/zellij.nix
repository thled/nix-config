{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ zellij ];
  environment.etc."config/zellij/config.kdl".source = ./zellij.kdl;
  environment.etc."config/zellij/zellij_zen.sh".source = ./zellij_zen.sh;
}
