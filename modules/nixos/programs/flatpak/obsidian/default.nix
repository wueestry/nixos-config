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
  cfg = config.${namespace}.programs.flatpak.obsidian;
in
{
  options.${namespace}.programs.flatpak.obsidian = with types; {
    enable = mkBoolOpt false "Enable Obsidian notes via Flatpak";
  };

  config = mkIf cfg.enable {
    services.flatpak.packages = [
      {
        appId = "md.obsidian.Obsidian";
        origin = "flathub";
      }
    ];
  };
}
