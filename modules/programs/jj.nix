{pkgs, ...}: {
  environment = {
    systemPackages = [pkgs.jujutsu];
    etc."config/jj/config.toml".text =
      #toml
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
        pager = ":builtin"
        diff-editor = ":builtin"
        merge-editor = ":builtin"

        [aliases]
        f = ["git", "fetch"]
        fetch = ["git", "fetch"]
        l = ["log", "-r", "::"]
        p = ["git", "push"]
        push = ["git", "push"]
        retrunk = ["rebase", "-d", "trunk()"]
        tug = ["bookmark", "move", "--from", "heads(::@- & bookmarks())", "--to", "@-"]
      '';
  };
}
