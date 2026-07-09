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
  cfg = config.${namespace}.programs.gui.nextcloud-client;
in
{
  options.${namespace}.programs.gui.nextcloud-client = with types; {
    enable = mkBoolOpt false "Enable nextcloud-client";
  };

  config = mkIf cfg.enable {
    services.nextcloud-client = {
      enable = true;
      package = pkgs.nextcloud-client;
      startInBackground = true;
    };
  };
}
