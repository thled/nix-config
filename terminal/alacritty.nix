{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.alacritty ];

  environment.etc."config/alacritty.yml".source = ./alacritty.yml;
}

