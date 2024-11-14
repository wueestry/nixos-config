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
  cfg = config.${namespace}.services.mealie;
in
{
  options.${namespace}.services.mealie = with types; {
    enable = mkBoolOpt false "Enable mealie";
  };

  config = mkIf cfg.enable {
    services.mealie = {
      enable = true;
      port = 8088;
      listenAddress = "0.0.0.0";
      settings = {
	TZ = "Europe/Zurich";
      };
    };
  };
}
