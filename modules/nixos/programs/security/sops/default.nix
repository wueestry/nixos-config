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
  cfg = config.${namespace}.programs.security.sops;
in
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  options.${namespace}.programs.security.sops = with types; {
    enable = mkBoolOpt false "Enable sops";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      age
      sops
      ssh-to-age
    ];

    sops.defaultSopsFile = ./../../../../secrets/secrets.yaml;
    sops.defaultSopsFormat = "yaml";

    sops.age.keyFile = "/home/${config.olympus.config.user.name}/.config/sops/age/keys.txt";
  };
}
