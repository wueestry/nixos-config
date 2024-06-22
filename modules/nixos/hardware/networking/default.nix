{
  options,
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.hardware.networking;
in {
  options.${namespace}.hardware.networking = with types; {
    enable = mkBoolOpt false "Enable networkmanager";
  };
  hostname = mkOpt str home.hostname "${namespace}.hardware.networking.hostname";

  config = mkIf cfg.enable {
    networking = {
      hostName = hostname;
      networkmanager.enable = true;
    };
  };
}
