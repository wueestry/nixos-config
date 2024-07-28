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
  cfg = config.${namespace}.misc.qt;
in {
  options.${namespace}.misc.qt = with types; {
    enable = mkBoolOpt false "Enable qt theme";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      libsForQt5.qt5ct
      libsForQt5.qtstyleplugin-kvantum
    ];
    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style = {
        name = "Catppuccin-Mocha-Teal";
        package = pkgs.catppuccin-kvantum.override {
          accent = "Teal";
          variant = "Mocha";
        };
      };
    };
    xdg.configFile = {
      "Kvantum/kvantum.kvconfig".text = ''
        [General]
        theme=Catppuccin-Mocha-Teal
      '';

      "Kvantum/Catppuccin".source = "${pkgs.catppuccin-kvantum}/share/Kvantum/Catppuccin-Mocha-Teal";
    };
  };
}
