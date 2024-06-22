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
  cfg = config.${namespace}.desktop.hyprland;
  display_switcher = pkgs.writeShellScriptBin "display_switcher" ''
    #!/bin/sh

    if [[ $(hyprctl monitors) == *"eDP-1"* ]]; then
      hyprctl keyword monitor "eDP-1, disable"
    else
      hyprctl keyword monitor "eDP-1, prefered, auto, auto"
    fi
  '';
in {
  options.${namespace}.desktop.hyprland = with types; {
    enable = mkBoolOpt false "Enable hyprland";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      #enableNvidiaPatches = true;
      extraConfig = import ./config.nix;
      systemd.enable = true;
      xwayland.enable = true;
    };
  };
}
