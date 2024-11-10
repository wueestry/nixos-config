{
  options,
  config,
  lib,
  pkgs,
  namespace,
  inputs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.programs.sops;
in
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  options.${namespace}.programs.sops = with types; {
    enable = mkBoolOpt false "Enable sops";
  };

  config = mkIf cfg.enable { 
    environment.systemPackages = with pkgs; [
      age
      sops
      ssh-to-age
    ];
  };
}
