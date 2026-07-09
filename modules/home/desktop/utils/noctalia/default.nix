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
  cfg = config.${namespace}.desktop.utils.noctalia;
in
{
  imports = [ inputs.noctalia.homeModules.default ];

  options.${namespace}.desktop.utils.noctalia = with types; {
    enable = mkBoolOpt false "Enable the noctalia desktop shell";
  };

  config = mkIf cfg.enable {
    programs.noctalia = {
      enable = true;
      settings = {
        theme = {
          mode = "dark";
          source = "builtin";
          builtin = "Catppuccin";
        };

        wallpaper = {
          enabled = true;
          default.path = toString config.stylix.image;
        };

        location = {
          name = "Zurich, Switzerland";
        };
      };
      # Anything not set here (bar widget layout, further theme tweaks, etc.)
      # can be configured live through noctalia's own settings UI, which
      # persists to ~/.local/state/noctalia/settings.toml. Once the layout is
      # settled, worth pulling the interesting bits back into this file.
    };
  };
}
