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
  cfg = config.${namespace}.desktop.utils.noctalia-shell;
in
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  options.${namespace}.desktop.utils.noctalia-shell = with types; {
    enable = mkBoolOpt false "Enable noctalia quickshell";
  };

  config = mkIf cfg.enable {
    programs.noctalia-shell = {
      enable = true;
      settings = {
        # configure noctalia here
        bar = {
          density = "compact";
          position = "top";
          showCapsule = false;
          widgets = {
            left = [
              {
                id = "ControlCenter";
                useDistroLogo = true;
              }
              {
                id = "Network";
              }
              {
                id = "Bluetooth";
              }
            ];
            center = [
              {
                hideUnoccupied = false;
                id = "Workspace";
                labelMode = "none";
              }
            ];
            right = [
              {
                alwaysShowPercentage = false;
                id = "Battery";
                warningThreshold = 30;
              }
              {
                formatHorizontal = "HH:mm";
                formatVertical = "HH mm";
                id = "Clock";
                useMonospacedFont = true;
                usePrimaryColor = true;
              }
            ];
          };
        };
        colorSchemes.predefinedScheme = "Monochrome";
        general = {
          avatarImage = "/home/${config.olympus.config.user.name}/.config/hypr/face.png";
          radiusRatio = 0.2;
        };
        location = {
          monthBeforeDay = false;
          name = "Zurich, Switzerland";
        };
      };
      # this may also be a string or a path to a JSON file.
    };
  };
}
