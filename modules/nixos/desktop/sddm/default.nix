{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.desktop.sddm;
in {
  options.${namespace}.desktop.sddm = with types; {
    enable =
      mkBoolOpt false "Whether or not to use sddm.";
  };

  config = mkIf cfg.enable {
    services = {
      xserver.enable = true;
      displayManager.sddm.enable = true;
    };
  };
}
