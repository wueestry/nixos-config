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
  cfg = config.${namespace}.services.media.jellyfin;
in
{
  options.${namespace}.services.media.jellyfin = with types; {
    enable = mkBoolOpt false "Enable jellyfin";
  };

  config = mkIf cfg.enable {
    services.media.jellyfin = {
      enable = true;
      dataDir = "/mnt/storage/jellyfin";
      # port = 8096; Non configurable
    };
  };
}
