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
  cfg = config.${namespace}.bundles.desktop.hyprland;
in {
  options.${namespace}.bundles.desktop.hyprland = with types; {
    enable = mkBoolOpt false "Whether or not to enable desktop hyprland bundle configuration.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; with gnome; [
      adwaita-icon-theme
      brightnessctl
      gnome-system-monitor
      gnome-control-center
      morewaita-icon-theme
      
      pavucontrol
      swww

      qogir-icon-theme

      wayshot
      wl-clipboard
      wl-gammactl
    ];
    
    zeus = {
      desktop.hyprland = enabled;
      programs = {
        nautilus = enabled;
        ags = enabled;
        #dolphin = enabled;
        #rofi = enabled;
        #waybar = enabled;
      };
    };
  };
}
