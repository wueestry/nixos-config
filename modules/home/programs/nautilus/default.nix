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
  cfg = config.${namespace}.programs.nautilus;
in {
  options.${namespace}.programs.nautilus = with types; {
    enable = mkBoolOpt false "Enable nautilus";
  };

  config =
    mkIf cfg.enable {      
        home = {
            sessionVariables.NAUTILUS_4_EXTENSION_DIR = "${pkgs.gnome.nautilus-python}/lib/nautilus/extensions-4";
            packages = with pkgs; [
                gnome.nautilus
                gnome.nautilus-python
            ];
        };

        programs.nautilus-open-any-terminal = {
            enable = true;
            terminal = "kitty";
        };

        environment.pathsToLink = [
            "/share/nautilus-python/extensions"
        ];
    };
}
