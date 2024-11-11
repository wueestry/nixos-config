{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    devenv.url = "github:cachix/devenv";
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs =
    {
      self,
      nixpkgs,
      devenv,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system}.devenv-up = self.devShells.${system}.default.config.procfileScript;
      packages.${system}.devenv-test = self.devShells.${system}.default.config.test;

      devShells.${system}.default = devenv.lib.mkShell {
        inherit inputs pkgs;
        modules = [
          (
            { pkgs, config, ... }:
            {
              # This is your devenv configuration
              packages = [
                git
              ];

              languages.python = {
                enable = true;
                package = pkgs.python311Full;
                poetry = {
                  enable = true;
                  install = {
                    enable = true;
                    installRootPackage = false;
                    onlyInstallRootPackage = false;
                    compile = false;
                    quiet = false;
                    groups = [ ];
                    ignoredGroups = [ ];
                    onlyGroups = [ ];
                    extras = [ ];
                    allExtras = false;
                    verbosity = "no";
                  };
                  activate.enable = true;
                  package = pkgs.poetry;
                };
              };

              enterShell = ''
                hello
                git --version
              '';
            }
          )
        ];
      };
    };
}
