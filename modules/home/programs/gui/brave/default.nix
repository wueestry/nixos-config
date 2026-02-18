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
  cfg = config.${namespace}.programs.gui.brave;
in
{
  options.${namespace}.programs.gui.brave = {
    enable = mkBoolOpt false "${namespace}.programs.gui.brave.enable";
  };

  config = mkIf cfg.enable {
    programs.gui.chromium = {
      enable = true;
      package = pkgs.brave;
    };
  };
}
