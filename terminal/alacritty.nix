{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.alacritty ];

  environment.etc."config/alacritty/alacritty.yml".source = ./alacritty.yml;
}

