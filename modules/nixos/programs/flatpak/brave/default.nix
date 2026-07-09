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
  cfg = config.${namespace}.programs.flatpak.brave;
in
{
  options.${namespace}.programs.flatpak.brave = with types; {
    enable = mkBoolOpt false "Enable Brave browser via Flatpak";
  };

  config = mkIf cfg.enable {
    services.flatpak.packages = [
      {
        appId = "com.brave.Browser";
        origin = "flathub";
      }
    ];
  };
}
