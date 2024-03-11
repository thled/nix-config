{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.foot ];
  # environment.etc."config/wezterm/wezterm.lua".source = ./wezterm.lua;
}
