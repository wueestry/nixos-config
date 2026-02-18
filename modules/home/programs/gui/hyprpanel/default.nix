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
  cfg = config.${namespace}.programs.gui.hyprpanel;

  transparentButtons = false;
  accent = "#${config.lib.stylix.colors.base0D}";
  accent-alt = "#${config.lib.stylix.colors.base03}";
  background = "#${config.lib.stylix.colors.base00}";
  background-alt = "#${config.lib.stylix.colors.base01}";
  foreground = "#${config.lib.stylix.colors.base05}";
  font = "${config.stylix.fonts.serif.name}";
  fontSize = "${toString config.stylix.fonts.sizes.desktop}";

  rounding = 10;
  border-size = 1;
  gaps-out = 5;
  gaps-in = 3;
  floating = true;
  transparent = true;
  position = "top";

  location = "Zurich";
  username = "ryan";
in
{
  options.${namespace}.programs.gui.hyprpanel = with types; {
    enable = mkBoolOpt false "Enable programs.gui.hyprpanel";
  };

  #  imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];

  config = mkIf cfg.enable {
    programs.gui.hyprpanel = {
      enable = true;
      systemd.enable = true;
    };
  };
}
