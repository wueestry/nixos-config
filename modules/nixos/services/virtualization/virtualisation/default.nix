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
  cfg = config.${namespace}.services.virtualization.network.monitoring.home-automation.media.virtualisation;
in
{
  options.${namespace}.services.virtualization.network.monitoring.home-automation.media.virtualisation = with types; {
    enable = mkBoolOpt false "Enable virtualisation";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      distrobox
      bottles
      docker-compose
    ];

    programs = {
      localsend = {
        enable = true;
      };
      virt-manager.enable = true;
    };

    virtualisation = {
      docker.enable = true;
      libvirtd.enable = true;
      spiceUSBRedirection.enable = true;
    };
  };
}
