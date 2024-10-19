{
  description = "";

  inputs = {
    # NixPkgs (nixos-24.05)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    # NixPkgs Unstable (nixos-unstable)
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    ### Additional Inputs ###

    # ags
    ags.url = "github:Aylur/ags";

    # Home Manager (release-24.05)
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hardware Configuration
    nixos-hardware.url = "github:nixos/nixos-hardware";

    # Neovim
    neovim = {
      url = "github:wueestry/nixvim-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Run unpatched dynamically compiled binaries
    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Snowfall Lib
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Stylix
    stylix.url = "github:danth/stylix";

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";

    # Hyprpanel
    hyprpanel = {
      #url = "github:Jas-SinghFSU/HyprPanel";
      url = "github:Jas-SinghFSU/HyprPanel?ref=f21d70949f9f4426f39d12f542ec788d47330763";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprswitch
    # hyprswitch.url = "github:h3rmt/hyprswitch/release";

    # Apple font
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
  };

  outputs =
    inputs:
    let
      lib = inputs.snowfall-lib.mkLib {
        inherit inputs;
        src = ./.;

        snowfall = {
          meta = {
            name = "zeus";
            title = "NixOS config nicknamed Zeus";
          };

          namespace = "zeus";
        };
      };
    in
    lib.mkFlake {
      inherit inputs;
      src = ./.;

      channels-config = {
        allowUnfree = true;
        permittedInsecurePackages = [ ];
      };

      overlays = with inputs; [ hyprpanel.overlay ];

      systems.modules.nixos = with inputs; [ ];

      systems.hosts.athena.modules = with inputs; [
        nixos-hardware.nixosModules.lenovo-yoga-7-14ARH7-nvidia
      ];

      templates = import ./templates { };
    };
}
