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
      "config/helix/themes/gruvbox_minimal.toml".source = ./gruvbox_minimal.toml;
      "config/helix/runtime/queries/rust/highlights.scm".source = ./helix_rust_highlights.scm;
      "config/helix/runtime/queries/php/highlights.scm".source = ./helix_php_highlights.scm;
      "config/helix/runtime/queries/php-only/highlights.scm".source = ./helix_php-only_highlights.scm;
      "config/helix/runtime/queries/typescript/highlights.scm".source = ./helix_ts_highlights.scm;
      "config/helix/runtime/queries/tsx/highlights.scm".source = ./helix_tsx_highlights.scm;
    };
  };
}
