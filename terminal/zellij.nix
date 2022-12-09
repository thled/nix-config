{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ zellij ];
  environment.etc."config/zellij/config.kdl".source = ./zellij.kdl;
}
