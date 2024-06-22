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
  cfg = config.${namespace}.desktop.hyprland;
in {
  options.${namespace}.desktop.hyprland = with types; {
    enable =
      mkBoolOpt false "Whether or not to use Hyprland as the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment = {
      sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
      systemPackages = with pkgs; [];
    };
    home = {
      packages = with pkgs; [];
      zeus = {
        bundles.desktop = enabled;
        programs.waybar = enabled;
      };
    };
  };
}
