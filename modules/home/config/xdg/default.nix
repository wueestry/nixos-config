{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.config.xdg;
in
{
  options.${namespace}.config.xdg = {
    enable = mkBoolOpt false "${namespace}.config.xdg.enable";
  };

  config = mkIf cfg.enable { xdg = enabled; };
}
