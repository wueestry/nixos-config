{
  options,
  config,
  lib,
  pkgs,
  namespace,
  inputs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.programs.gui.zen;
in
{
  options.${namespace}.programs.gui.zen = with types; {
    enable = mkBoolOpt false "Enable module";
  };

  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  config = mkIf cfg.enable {
    programs.gui.zen-browser = {
      enable = true;
      policies = {
        DisableAppUpdate = true;
        DisableTelemetry = true;
        # find more options here: https://mozilla.github.io/policy-templates/
      };
    };
  };
}
