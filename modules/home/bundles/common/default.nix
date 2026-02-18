{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.bundles.common;
in
{
  options.${namespace}.bundles.common = with types; {
    enable = mkBoolOpt false "Whether or not to enable common bundle configuration.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Terminal
      btop
      coreutils
      killall
      tldr
      wget

      # Video/Audio
      celluloid
      loupe

      # File Management
      unrar
      unzip
      zip

      fastfetch

      # Config formatting
      nixfmt-rfc-style
    ];
    olympus = {
      bundles.shell = enabled;
      config = {
        apps = enabled;
      };
      gui = {
        gtk = disabled;
        qt = disabled;
      };
      utilities = enabled;
      programs = {
        cli = {
          brave = enabled;
          kitty = enabled;
          librewolf = disabled;
          lazygit = enabled;
          neovim = enabled;
        };
        gui = {
          stylix = enabled;
          tmux = enabled;
          zen = enabled;
        };
      };
    };
  };
}
