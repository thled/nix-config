{ pkgs, ... }: {
  environment = {
    systemPackages = [ pkgs.jujutsu ];
    etc."config/jj/config.toml".text = #toml
    ''
      [user]
      name = "Thomas Le Duc"
      email = "dev@tleduc.de"

      [[--scope]]
      --when.repositories = ["~/work"]
      [--scope.user]
      email = "leduc@publicplan.de"

      [ui]
      default-command = ["log", "--no-pager", "--reversed"]
    '';
  };
}
