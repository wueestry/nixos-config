{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.virtualisation;
in {
  options.${namespace}.services.virtualisation = with types; {
    enable = mkBoolOpt false "Enable virtualisation";
  };

  config =
    mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            boxbuddy
            distrobox
        ];

        programs.virt-manager.enable = true;

        virtualisation = {
            docker.enable = true;
            libvirtd.enable = true;
        };
    };
}
