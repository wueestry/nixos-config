inputs:
{
  mkHost = { hostname, system ? "x86_64-linux", users ? [ ] }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        ../hosts/${hostname}
        ../modules/nixos

        inputs.nix-flatpak.nixosModules.nix-flatpak
        inputs.sops-nix.nixosModules.sops
        inputs.niri.nixosModules.niri
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };
            sharedModules = [ inputs.noctalia.homeModules.default ];
            users = inputs.nixpkgs.lib.genAttrs users (user: import ../home/${user});
          };
        }
      ];
    };

  mkMicrovm = { name, system ? "x86_64-linux" }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        inputs.microvm.nixosModules.microvm
        ../vms/${name}
      ];
    };
}
