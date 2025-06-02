{
  pkgs,
  ghostty,
  ...
}: {
  environment.systemPackages = [ghostty.packages."${pkgs.system}".default];
  environment.etc."config/ghostty/config".source = ./ghosttyrc;
}
