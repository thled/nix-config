{
  pkgs,
  ghostty,
  ...
}: {
  environment.systemPackages = [ghostty.packages."${pkgs.stdenv.hostPlatform.system}".default];
  environment.etc."config/ghostty/config".source = ./ghosttyrc;
}
