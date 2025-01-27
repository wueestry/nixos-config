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
  cfg = config.${namespace}.programs.cavalier;
in
{
  options.${namespace}.programs.cavalier = with types; {
    enable = mkBoolOpt false "Enable cavalier";
  };

  config = mkIf cfg.enable { };
}
