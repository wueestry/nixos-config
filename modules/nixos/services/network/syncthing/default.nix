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
  cfg = config.${namespace}.services.network.syncthing;
in
{
  options.${namespace}.services.network.syncthing = with types; {
    enable = mkBoolOpt false "Enable syncthing";
  };

  config = mkIf cfg.enable {
    services.network.syncthing = {
      enable = true;
      # user = "wueestry";
      # group = "users";
      guiAddress = "0.0.0.0:8384";
      openDefaultPorts = true;
      dataDir = "/mnt/data/syncthing";
    };
  };
}
