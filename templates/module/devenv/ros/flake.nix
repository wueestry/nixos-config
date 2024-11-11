{
  inputs = {
    nix-ros-overlay.url = "github:lopsided98/nix-ros-overlay/master";
    # nixpkgs.follows = "nix-ros-overlay/nixpkgs";  # IMPORTANT!!!
    nixpkgs.url = "github:cachix/devenv-nixpkgs/rolling";
    systems.url = "github:nix-systems/default";
    devenv = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    extra-trusted-public-keys = [
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo="
    ];
    extra-substituters = [
      "https://devenv.cachix.org"
      "https://ros.cachix.org"
    ];
  };

  outputs =
    {
      self,
      nixpkgs,
      devenv,
      systems,
      nix-ros-overlay,
      ...
    }@inputs:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      packages = forEachSystem (system: {
        devenv-up = self.devShells.${system}.default.config.procfileScript;
      });

      devShells = forEachSystem (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ nix-ros-overlay.overlays.default ];
          };
        in
        {
          default = devenv.lib.mkShell {
            inherit inputs pkgs;
            modules = [
              {
                # https://devenv.sh/reference/options/
                packages = (
                  with pkgs;
                  with rosPackages.humble;
                  [
                    # Change ros version here
                    colcon
                    ros-core # Add other packages here
                  ]
                );
              }
            ];
          };
        }
      );
    };
}
