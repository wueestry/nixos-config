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
  cfg = config.${namespace}.bundles.desktop;
in {
  options.${namespace}.bundles.desktop = with types; {
    enable = mkBoolOpt false "Whether or not to enable desktop bundle configuration.";
  };

  config = mkIf cfg.enable {
    zeus = {
      desktop.hyprland = enabled;
      programs = {
        rofi = enabled;
      };
    };
  };
}
