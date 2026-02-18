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
  cfg = config.${namespace}.programs.flatpak.core;
in
{
  options.${namespace}.programs.flatpak.core = with types; {
    enable = mkBoolOpt false "Enable flatpak support";
  };

  config = mkIf cfg.enable {
    services.flatpak = {
      enable = true;
    };
  };
}
