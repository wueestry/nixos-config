{
  description = "Ryan's NixOS configuration";

  nixConfig = {
    extra-substituters = [ "https://microvm.cachix.org" ];
    extra-trusted-public-keys = [ "microvm.cachix.org-1:oXnBc6hRE3eX5rSYdRyMYXnfzcCxC7yKPTbZXALsqys=" ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Noctalia (via quickshell) tracks bleeding-edge nixpkgs internally;
    # deliberately NOT following our stable nixpkgs here to avoid breaking
    # its build against a quickshell version it doesn't expect.
    noctalia.url = "github:noctalia-dev/noctalia/legacy-v4";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    microvm = {
      url = "github:microvm-nix/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, nix-flatpak, sops-nix, niri, noctalia, nixos-hardware, microvm, ... }:
    let
      lib = import ./lib inputs;
    in
    {
      nixosConfigurations = {
        athena = lib.mkHost {
          hostname = "athena";
          users = [ "ryan" ];
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
