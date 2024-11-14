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
  cfg = config.${namespace}.services.firefly-iii;
in
{
  options.${namespace}.services.firefly-iii = with types; {
    enable = mkBoolOpt false "Enable firefly iii";
  };

  config = mkIf cfg.enable { 
	services.firefly-iii = {
		enable = true;
		dataDir = "/mnt/storage/firefly-iii";
		virtualHost = "0.0.0.0";

		settings = {
			APP_KEY_FILE = config.sops.secrets.firefly-key.path;
		};
	};
  };
}
