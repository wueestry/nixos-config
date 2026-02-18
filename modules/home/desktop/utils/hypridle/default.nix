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
  cfg = config.${namespace}.desktop.utils.hypridle;
in
{
  options.${namespace}.desktop.utils.hypridle = with types; {
    enable = mkBoolOpt false "Enable desktop.utils.hypridle";
  };

  config = mkIf cfg.enable {
    services.hypridle = {
      enable = false;
      settings = {
        general = {
          ignore_dbus_inhibit = false;
          lock_cmd = "pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };

        listener = [
          {
            timeout = 600;
            on-timeout = "pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
          }

          {
            timeout = 660;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };
  };
}
