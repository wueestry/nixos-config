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
    zeus = {
      programs = {
        brave = enabled;
        kitty = enabled;
        neovim = enabled;
        zsh = enabled;
      };
    };
  };
}