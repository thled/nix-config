{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [eww];
  environment.etc."config/eww".source = ./eww-bar;
}

