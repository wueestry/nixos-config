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
  cfg = config.${namespace}.misc.gtk;
in {
  options.${namespace}.misc.gtk = with types; {
    enable = mkBoolOpt false "Enable gtk";
  };

  config = mkIf cfg.enable {
    gtk = {
      enable = true;

      cursorTheme = {
        name = "macOS-BigSur";
        package = pkgs.apple-cursor;
        size = 32; # Affects gtk applications as the name suggests
      };

      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
    };
  };
}
