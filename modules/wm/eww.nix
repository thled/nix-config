{ pkgs, ... }: {
  environment.systemPackages = [(pkgs.callPackage ./eww-override.nix { })];
  environment.etc."config/eww".source = ./eww-bar;
}

