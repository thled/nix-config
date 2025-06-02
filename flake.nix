{
  description = "Thled's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # master.url = "github:NixOS/nixpkgs/master";

    ghostty.url = "github:ghostty-org/ghostty";
    helix.url = "github:helix-editor/helix/master";
    zen-browser.url = "github:youwen5/zen-browser-flake";

    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: {
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
