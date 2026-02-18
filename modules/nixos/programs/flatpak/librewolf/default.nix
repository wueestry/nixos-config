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
  cfg = config.${namespace}.programs.flatpak.librewolf;
in
{
  options.${namespace}.programs.flatpak.librewolf = with types; {
    enable = mkBoolOpt false "Enable LibreWolf browser via Flatpak";
  };

  config = mkIf cfg.enable {
    services.flatpak.packages = [
      {
        appId = "io.gitlab.librewolf_app";
        origin = "flathub";
      }
    ];
  };
}
