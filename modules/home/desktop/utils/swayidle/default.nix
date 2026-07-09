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
  cfg = config.${namespace}.desktop.utils.swayidle;

  # `noctalia` is put on PATH by `programs.noctalia.enable`
  # (olympus.desktop.utils.noctalia), which this module depends on.
  lock = "noctalia msg session lock";
in
{
  options.${namespace}.desktop.utils.swayidle = with types; {
    enable = mkBoolOpt false "Enable idle-timeout handling (noctalia has no built-in idle daemon)";
  };

  config = mkIf cfg.enable {
    services.swayidle = {
      enable = true;
      timeouts = [
        {
          timeout = 600;
          command = lock;
        }
        {
          timeout = 660;
          command = "systemctl suspend";
        }
      ];
      beforeSleepCmd = lock;
    };
  };
}
