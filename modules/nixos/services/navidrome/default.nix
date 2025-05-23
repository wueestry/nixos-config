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
  cfg = config.${namespace}.services.navidrome;
in
{
  options.${namespace}.services.navidrome = with types; {
    enable = mkBoolOpt false "Enable navidrome";
  };

  config = mkIf cfg.enable {
    sops.secrets = {
      last-fm-key = {
        owner = "navidrome";
      };
      last-fm-secret = {
        owner = "navidrome";
      };
    };

    services.navidrome = {
      enable = true;
      settings = {
        Address = "0.0.0.0";
        Port = 4533;
        MusicFolder = "/mnt/storage/navidrome/music";
        LastFM.ApiKey = "$(cat ${config.sops.secrets.last-fm-key.path})";
        LastFM.Secret = "$(cat ${config.sops.secrets.last-fm-secret.path})";
      };
    };
  };
}
