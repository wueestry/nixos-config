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
  cfg = config.${namespace}.programs.flatpak.zen;
in
{
  options.${namespace}.programs.flatpak.zen = with types; {
    enable = mkBoolOpt false "Enable Zen Browser via Flatpak";
  };

  config = mkIf cfg.enable {
    services.flatpak.packages = [
      {
        appId = "com.zen_browser.zen";
        origin = "flathub";
      }
    ];
  };
}
