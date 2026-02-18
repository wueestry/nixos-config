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
  cfg = config.${namespace}.services.home-automation.firefly-iii;
in
{
  options.${namespace}.services.home-automation.firefly-iii = with types; {
    enable = mkBoolOpt false "Enable firefly iii";
  };

  config = mkIf cfg.enable {
    sops.secrets.firefly-key = {
      owner = "firefly-iii";
    };

    services.home-automation.firefly-iii = {

      enable = true;

      settings = {
        APP_ENV = "production";
        APP_KEY_FILE = config.sops.secrets.firefly-key.path;

        DB_CONNECTION = "sqlite";

        TZ = "Europe/Zurich";
        EXPECT_SECURE_URL = "false";
        TRUSTED_PROXIES = "**";
      };
      enableNginx = true;
      virtualHost = "apollo.firefly-iii.home";

      dataDir = "/var/lib/firefly-iii";
    };

    services.home-automation.nginx.virtualHosts.${config.services.home-automation.firefly-iii.virtualHost} =
      {
        enableACME = false;
        listen = [
          {
            addr = "0.0.0.0";
            port = 9080;
          }
        ];
      };
  };
}
