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
  cfg = config.${namespace}.programs.flatpak.spotify;
in
{
  options.${namespace}.programs.flatpak.spotify = with types; {
    enable = mkBoolOpt false "Enable Spotify via Flatpak";
  };

  config = mkIf cfg.enable {
    services.flatpak.packages = [
      {
        appId = "com.spotify.Client";
        origin = "flathub";
      }
    ];
  };
}
