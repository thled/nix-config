{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.eww];
  environment.etc."config/eww".source = ./eww-bar;
}

