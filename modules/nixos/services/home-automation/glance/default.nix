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
  cfg = config.${namespace}.services.home-automation.glance;
in
{
  options.${namespace}.services.home-automation.glance = with types; {
    enable = mkBoolOpt false "Enable glance";
  };

  config = mkIf cfg.enable {
    services.home-automation.glance = {
      enable = true;
      settings = {
        server = {
          host = "0.0.0.0";
          port = 5678;
        };
      };
    };
  };
}
