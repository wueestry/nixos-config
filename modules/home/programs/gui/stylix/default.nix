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
  cfg = config.${namespace}.programs.gui.stylix;
in
{
  options.${namespace}.programs.gui.stylix = with types; {
    enable = mkBoolOpt false "Enable stylix";
  };

  imports = [ inputs.stylix.homeModules.stylix ];

  config = mkIf cfg.enable {
    stylix = {
      enable = true;

      autoEnable = true;
      base16Scheme = ./base16/catppuccin/custom.yaml;
      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Original-Ice";
        size = 24;
      };

      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font Mono";
        };
        sansSerif = {
          package = inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd;
          name = "SFProDisplay Nerd Font";
        };
        serif = {
          package = inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd;
          name = "SFProDisplay Nerd Font";
        };
        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
        sizes = {
          applications = 13;
          desktop = 13;
          popups = 13;
          terminal = 13;
        };
      };

      iconTheme = {
        enable = true;
        package = pkgs.papirus-icon-theme;
        light = "Papirus-Light";
        dark = "Papirus-Dark";
      };

      image = ./wallpapers/sports.png;

      polarity = "dark";

      # kitty keeps its own explicit Catppuccin-Mocha themeFile, and neovim's
      # colorscheme is managed on its own terms - avoid stylix fighting either.
      targets = {
        kitty.enable = false;
        neovim.enable = false;
      };
    };
  };
}
