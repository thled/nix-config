{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ direnv nix-direnv ];

  nix.settings = {
    keep-outputs = true;
    keep-derivations = true;
  };
  environment.pathsToLink = [
    "/share/nix-direnv"
  ];

  nixpkgs.overlays = [
    (self: super: { nix-direnv = super.nix-direnv.override { enableFlakes = true; }; } )
  ];

  environment.etc."config/direnv/direnvrc".source = ./direnvrc;
}
