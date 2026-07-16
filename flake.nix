{
  description = "Ryan's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      lib = import ./lib inputs;
    in
    {
      nixosConfigurations = {
        athena = lib.mkHost {
          hostname = "athena";
          users = [ "ryan" ];
        };
      };
    };
}
