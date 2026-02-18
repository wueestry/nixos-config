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
  cfg = config.${namespace}.programs.gui.freetube;
in
{
  options.${namespace}.programs.gui.freetube = with types; {
    enable = mkBoolOpt false "Enable freetube";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      freetube
    ];
  };
}
