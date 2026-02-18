{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.programs.gui.librewolf;
in
{
  options.${namespace}.programs.gui.librewolf = {
    enable = mkBoolOpt false "${namespace}.programs.gui.librewolf.enable";
  };

  config = mkIf cfg.enable {
    programs.gui.librewolf = {
      enable = true;
    };
  };
}
