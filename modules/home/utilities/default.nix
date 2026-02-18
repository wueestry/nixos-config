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
  cfg = config.${namespace}.utilities;
in
{
  options.${namespace}.utilities = with types; {
    enable = mkBoolOpt false "Enable utilities";
  };

  config = mkIf cfg.enable {
    olympus.utilities = {
      brightness = enabled;
      caffeine = enabled;
      hyprfocus = enabled;
      hyprpanel = enabled;
      night_shift = enabled;
      notification = enabled;
      screenshot = enabled;
      sounds = enabled;
      system = enabled;
    };
  };
}
