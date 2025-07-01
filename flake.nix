{
  description = "Thled's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    master.url = "github:NixOS/nixpkgs/master";

    ghostty.url = "github:ghostty-org/ghostty";
    helix.url = "github:helix-editor/helix/master";
    zen-browser.url = "github:youwen5/zen-browser-flake";

    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    master,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs-master = import master {inherit system;};
  in {
    nixosConfigurations = {
      "NBL0112" = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = inputs // {master = pkgs-master;};
        modules = [
          ./configuration.nix
        ];
      };
    };
  };
}
