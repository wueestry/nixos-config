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
  imports = [ inputs.sops-nix.nixosModules.sops ];

  options.${namespace}.services.nextcloud = with types; {
    enable = mkBoolOpt false "Enable nextcloud";
  };

  config = mkIf cfg.enable {
    sops.secrets.nextcloud-admin = {
      owner = "nextcloud";
    };

    services.nextcloud = {
      enable = true;
      configureRedis = true;
      package = pkgs.nextcloud29;
      hostName = "nix-nextcloud";
      home = "/mnt/storage/nextcloud";

      config = {
        dbtype = "pgsql";
        dbuser = "nextcloud";
        dbhost = "/run/postgresql";
        dbname = "nextcloud";
        adminpassFile = config.sops.secrets.nextcloud-admin.path;
        adminuser = "admin";
        trustedProxies = [
          "localhost"
          "127.0.0.1"
          "100.120.33.43"
        ];
      };
    };
    services.postgresql = {
      enable = true;
      ensureDatabases = [ "nextcloud" ];
      #ensureUsers = [
      #{ name = "nextcloud";
      #ensurePermissions."DATABASE nextcloud" = "ALL PRIVILEGES";
      #}
      #];
    };
    systemd.services."nextcloud-setup" = {
      requires = [ "postgresql.service" ];
      after = [ "postgresql.service" ];
    };
    services.nginx.virtualHosts."nix-nextcloud".listen = [
      {
        addr = "127.0.0.1";
        port = 8011;
      }
    ];
  };
}
