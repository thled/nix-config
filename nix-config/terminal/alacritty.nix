{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.alacritty ];

  environment.etc.alacritty = {
    target = "config/alacritty/alacritty.yml";
    source = ./alacritty.yml;
    mode = "0755";
    user = "thled";
  };
}

