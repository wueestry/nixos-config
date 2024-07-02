{
  options,
  config,
  lib,
  pkgs,
  inputs,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; 
let
  cfg = config.${namespace}.programs.stylix;
in {
  options.${namespace}.programs.stylix = with types; {
    enable = mkBoolOpt false "Enable stylix";
  };

  imports = [inputs.stylix.homeManagerModules.stylix];

  config = mkIf cfg.enable {
    stylix = {
      enable = true;

      autoEnable = true;
      base16Scheme = ./base16/catppuccin/mocha.yaml;
      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Original-Ice";
        size = 32;
      };

      image = ./wallpapers/yosemite.png;

      polarity = "dark";
      targets = {
        kitty.enable = false;
        waybar.enable = false;
      };
    };
  };
}
