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
  cfg = config.${namespace}.programs.gui.walker;
in
{
  options.${namespace}.programs.gui.walker = with types; {
    enable = mkBoolOpt false "Enable programs.gui.walker";
  };

  config = mkIf cfg.enable {
    home.packages = (
      with pkgs;
      [
        walker
      ]
    );
  };
}
