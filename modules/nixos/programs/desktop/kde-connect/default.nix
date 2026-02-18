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
  cfg = config.${namespace}.programs.desktop.kde-connect;
in
{
  options.${namespace}.programs.desktop.kde-connect = with types; {
    enable = mkBoolOpt false "Enable kde connect";
  };

  config = mkIf cfg.enable { programs.kdeconnect.enable = true; };
}
