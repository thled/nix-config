{ pkgs, ... }: 
let
  myZellij = pkgs.zellij.overrideAttrs (final: previous: {
    src = pkgs.fetchFromGitHub {
      owner = "thled";
      repo = "zellij";
      rev = "query-pane-names";
      sha256 = "sha256-LD+1cKd7DCkergHhmoXI9+PtRdPRRCnKvpxM/GHSy9I=";
    };
  });
in {
  environment.systemPackages = [ myZellij ];
  environment.etc."config/zellij/config.kdl".source = ./zellij.kdl;
  environment.etc."config/zellij/zellij_zen.sh".source = ./zellij_zen.sh;
}
