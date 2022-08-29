{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ zellij ];
  environment.etc."config/zellij/config.yaml".source = ./zellij.yaml;
}

