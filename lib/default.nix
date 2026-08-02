inputs:
{
  mkHost = { hostname, system ? "x86_64-linux" }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        ../hosts/${hostname}
        ../modules/nixos

        inputs.nix-flatpak.nixosModules.nix-flatpak
        inputs.sops-nix.nixosModules.sops
        inputs.dms.nixosModules.dank-material-shell
        inputs.dms.nixosModules.greeter
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
