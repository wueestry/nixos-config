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
  musicDir = "/mnt/data/navidrome/music";
  beetsUser = "navidrome";
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
      acustid = {
        owner = "navidrome";
      };
      spotify-client = {
        owner = "navidrome";
      };
      spotify-secret = {
        owner = "navidrome";
      };
    };

    services.navidrome = {
      enable = true;
      settings = {
        Address = "0.0.0.0";
        Port = 4533;
        MusicFolder = musicDir;
        user = "navidrome";
        group = "navidrome";
        Spotify.ID = "$(cat ${config.sops.secrets.spotify-client.path})";
        Spotify.Secret = "$(cat ${config.sops.secrets.spotify-secret.path})";
        LastFM.ApiKey = "$(cat ${config.sops.secrets.last-fm-key.path})";
        LastFM.Secret = "$(cat ${config.sops.secrets.last-fm-secret.path})";
      };
    };
    environment.systemPackages = with pkgs; [ beets ];
  };
}
