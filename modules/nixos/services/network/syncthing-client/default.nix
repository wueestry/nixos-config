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
  cfg = config.${namespace}.services.virtualization.network.monitoring.home-automation.media.syncthing-client;
in
{
  options.${namespace}.services.virtualization.network.monitoring.home-automation.media.syncthing-client = with types; {
    enable = mkBoolOpt false "Enable syncthing";
  };

  config = mkIf cfg.enable {
    services.virtualization.network.monitoring.home-automation.media.syncthing = {
      enable = true;
      openDefaultPorts = true;
      guiAddress = "0.0.0.0:8384";
      user = "ryan";
      group = "users";
      dataDir = "/home/ryan/.syncthing";
    };
  };
}
