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
  cfg = config.${namespace}.bundles.common;
in {
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
    ];
    zeus = {
      programs = {
        brave = enabled;
        kitty = enabled;
        librewolf = enabled;
        neovim = enabled;
        stylix = disabled;
        starship = disabled;
        zsh = enabled;
      };
    };
  };
}
