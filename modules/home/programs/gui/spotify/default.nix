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
  cfg = config.${namespace}.programs.gui.spotify;
in
{
  options.${namespace}.programs.gui.spotify = with types; {
    enable = mkBoolOpt false "Enable ncspot a spotify client";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      spotify-player
    ];
  };
}
