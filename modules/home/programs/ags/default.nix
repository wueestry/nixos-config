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
  cfg = config.${namespace}.module;
in {
  options.${namespace}.module = with types; {
    enable = mkBoolOpt false "Enable module";
  };

  config =
    mkIf cfg.enable {
        home.packages = with pkgs; [
            brightnessctl
            bun
            dart-sass
            fd
            gtk3
            hyprpicker
            matugen
            networkmanager
            pavucontrol
            slurp
            swappy
            swww
            wayshot
            wf-recorder
            wl-clipboard
        ];

        programs.ags = {
            enable = true;
            configDir = ./config;
            extraPackages = with pkgs; [
                accountsservice
            ];
        };
    };
}
