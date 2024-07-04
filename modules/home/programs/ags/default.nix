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
with lib.${namespace}; let
  cfg = config.${namespace}.programs.ags;
in {
  imports = [inputs.ags.homeManagerModules.default];

  options.${namespace}.programs.ags = with types; {
    enable = mkBoolOpt false "Enable ags";
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
