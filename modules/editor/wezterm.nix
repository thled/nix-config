{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.wezterm ];
  environment.etc."config/wezterm/wezterm.lua".source = ./wezterm.lua;
}
