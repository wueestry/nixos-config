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
  cfg = config.${namespace}.services.home-automation.readeck;
in
{
  options.${namespace}.services.home-automation.readeck = with types; {
    enable = mkBoolOpt false "Enable readeck";
  };

  config = mkIf cfg.enable {
    sops.secrets = {
      readeck-key = { };
    };

    services.home-automation.readeck = {
      enable = true;
      settings = {
        main = {
          log_level = "info";
          secret_key = "$(cat ${config.sops.secrets.readeck-key.path})";
          # data_directory = "/mnt/data/readeck/data";
        };
        server = {
          host = "0.0.0.0";
          port = 9030;
        };
      };
    };
  };
}
