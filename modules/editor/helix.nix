{
  pkgs,
  helix,
  ...
}: {
  environment = {
    systemPackages = [helix.packages."${pkgs.stdenv.hostPlatform.system}".helix];
    etc = {
      "config/helix/config.toml".source = ./helix.toml;
      "config/helix/languages.toml".source = ./helix_languages.toml;
    };
  };
}
