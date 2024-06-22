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
    home.packages = with pkgs; [
      blueman
      pamixer
      slurp
      swappy
      swaybg

      wl-clipboard
      wlogout
      wlr-randr
    ];
    zeus = {
      desktop.hyprland = enabled;
      programs = {
        rofi = enabled;
        waybar = enabled;
      };
    };
  };
}
