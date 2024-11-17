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
  cfg = config.${namespace}.services.nextcloud;
in
{
  options.${namespace}.services.nextcloud = with types; {
    enable = mkBoolOpt false "Enable nextcloud";
  };

  config = mkIf cfg.enable {
    sops.secrets.nextcloud-admin = {
      owner = "nextcloud";
      group = "nextcloud";
    };

    services.nextcloud = {
      enable = true;
      configureRedis = true;
      package = pkgs.nextcloud30;
      hostName = "apollo.nextcloud.home";
      #home = "/var/lib/nextcloud";
      datadir = "/mnt/storage/nextcloud";
      database.createLocally = true;
      extraAppsEnable = true;
      autoUpdateApps.enable = true;

      config = {
        dbtype = "pgsql";
        adminpassFile = config.sops.secrets.nextcloud-admin.path;
        adminuser = "admin";
      };
      settings = {
	trusted_domains = [
	"localhost"
	"127.0.0.1"
	"100.123.33.43"
	"apollo"
	];
      };
    };

#services.postgresqlBackup = {
#      enable = true;
#      startAt = "*-*-* 01:15:00";
#    };

    services.nginx.virtualHosts.${config.services.nextcloud.hostName}.listen = [
      {
        addr = "0.0.0.0";
        port = 8081;
      }
    ];
  };
}
