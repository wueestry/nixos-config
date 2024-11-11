{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.programs.devenv;
in
{
  options.${namespace}.programs.devenv = with types; {
    enable = mkBoolOpt false "Enable devenv";
  };

  config = mkIf cfg.enable { 
      home.packages = with pkgs; [
        devenv
      ];
      programs.direnv = {
          enable = true;
          enableZshIntegration = true;
          nix-direnv = true;
        };
    };
}
