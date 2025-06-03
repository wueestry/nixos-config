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
  cfg = config.${namespace}.services.syncthing;
in
{
  options.${namespace}.services.syncthing = with types; {
    enable = mkBoolOpt false "Enable syncthing";
  };

  config = mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      guiAddress = "0.0.0.0:8384";
      dataDir = "/mnt/data/syncthing";
      openDefaultPorts = true;
    };
  };
}
