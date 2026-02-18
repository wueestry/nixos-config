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
  cfg = config.${namespace}.programs.gui.gimp;
in
{
  options.${namespace}.programs.gui.gimp = with types; {
    enable = mkBoolOpt false "Enable gimp";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gimp
    ];
  };
}
