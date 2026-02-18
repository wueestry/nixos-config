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
  cfg = config.${namespace}.programs.gui.dolphin;
in
{
  options.${namespace}.programs.gui.dolphin = with types; {
    enable = mkBoolOpt false "Enable dolphin";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs.kdePackages; [
      ark
      dolphin
      dolphin-plugins
    ];
  };
}
