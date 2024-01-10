{
  description = "Thled's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # master.url = "github:NixOS/nixpkgs/master";

    helix.url = "github:helix-editor/helix/master";
    statix.url = "github:NerdyPepper/statix/master";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      "NBL0112" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = inputs;
        modules = [
          ./configuration.nix
        ];
      };
    };
  };
}
