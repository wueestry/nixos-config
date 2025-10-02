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
  cfg = config.${namespace}.services.glance;
in
{
  options.${namespace}.services.glane = with types; {
    enable = mkBoolOpt false "Enable glance";
  };

  config = mkIf cfg.enable {
    services.glance = {
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
