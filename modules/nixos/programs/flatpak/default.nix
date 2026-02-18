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
  cfg = config.${namespace}.programs.flatpak;
in
{
  options.${namespace}.programs.flatpak = with types; {
    enable = mkBoolOpt false "Enable flatpak support";
  };

  config = mkIf cfg.enable {
    services.flatpak = {
      enable = true;
    };
  };
}
