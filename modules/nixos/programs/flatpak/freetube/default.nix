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
  cfg = config.${namespace}.programs.flatpak.freetube;
in
{
  options.${namespace}.programs.flatpak.freetube = with types; {
    enable = mkBoolOpt false "Enable FreeTube via Flatpak";
  };

  config = mkIf cfg.enable {
    services.flatpak.packages = [
      {
        appId = "io.freetubeapp.FreeTube";
        origin = "flathub";
      }
    ];
  };
}
