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
  cfg = config.${namespace}.desktop.niri;
in
{
  options.${namespace}.desktop.niri = with types; {
    enable = mkBoolOpt false "Whether or not to use niri as the desktop compositor.";
  };

  config = mkIf cfg.enable {
    programs.niri.enable = true;

    services = {
      gvfs.enable = true;
      devmon.enable = true;
      upower.enable = true;
    };

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
      ];
    };

    olympus = {
      services = {
        greetd = enabled;
        polkit-gnome = enabled;
      };
    };
  };
}
