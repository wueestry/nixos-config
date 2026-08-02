{
  description = "Ryan's NixOS configuration";

  nixConfig = {
    extra-substituters = [ "https://microvm.cachix.org" ];
    extra-trusted-public-keys = [ "microvm.cachix.org-1:oXnBc6hRE3eX5rSYdRyMYXnfzcCxC7yKPTbZXALsqys=" ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    microvm = {
      url = "github:microvm-nix/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, nix-flatpak, sops-nix, dms, dgop, nixos-hardware, microvm, ... }:
    let
      lib = import ./lib inputs;
    in
    {
      nixosConfigurations = {
        athena = lib.mkHost {
          hostname = "athena";
        };

        # Template MicroVM — see vms/example/. Copy that directory to add
        # more isolated per-app VMs.
        "example-vm" = lib.mkMicrovm {
          name = "example";
        };
      };

      packages.x86_64-linux."example-vm" =
        self.nixosConfigurations."example-vm".config.microvm.declaredRunner;
    };
}
