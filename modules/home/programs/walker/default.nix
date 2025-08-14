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
  cfg = config.${namespace}.programs.walker;
in
{
  options.${namespace}.programs.walker = with types; {
    enable = mkBoolOpt false "Enable programs.walker";
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
