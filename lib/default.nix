inputs:
{
  mkHost = { hostname, system ? "x86_64-linux", users ? [ ] }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        ../hosts/${hostname}
        ../modules/nixos

        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };
            users = inputs.nixpkgs.lib.genAttrs users (user: import ../home/${user});
          };
        }
      ];
    };
}
