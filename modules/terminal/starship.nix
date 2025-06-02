{lib, ...}: {
  programs.starship = {
    enable = true;
    settings = lib.importTOML ./starship.toml;
  };
}
