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
  cfg = config.${namespace}.programs.kitty;
in {
  options.${namespace}.programs.kitty = with types; {
    enable = mkBoolOpt false "Enable kitty";
  };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      font = {
        name = "MesloLGS NF";
        package = pkgs.meslo-lgs-nf;
      };
      theme = "Catppuccin-Mocha";
      shellIntegration = {
        mode = "enabled";
        enableZshIntegration = true;
      };
    };
  };
}
