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
  cfg = config.${namespace}.programs.desktop.dconf;
in
{
  options.${namespace}.programs.desktop.dconf = with types; {
    enable = mkBoolOpt false "Enable dconf";
  };

  config = mkIf cfg.enable { programs.dconf.enable = true; };
}
