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
  cfg = config.${namespace}.services.home-automation.immich;
in
{
  options.${namespace}.services.home-automation.immich = with types; {
    enable = mkBoolOpt false "Enable immich";
  };

  config = mkIf cfg.enable {
    services.home-automation.immich = {
      enable = true;

      port = 3001;
      # package = inputs.unstable.legacyPackages.x86_64-linux.immich;
      host = "0.0.0.0";
      mediaLocation = "/mnt/storage/immich";

      accelerationDevices = null;

      machine-learning = {
        enable = true;
      };
      redis = {
        enable = true;
        host = "0.0.0.0";
        port = 6379;
      };

      environment = {
        TZ = "Europe/Zurich";
      };

      database = {
        enable = true;
      };
    };
  };
}
