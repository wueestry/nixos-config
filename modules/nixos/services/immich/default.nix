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
  cfg = config.${namespace}.services.immich;
in
{
  options.${namespace}.services.immich = with types; {
    enable = mkBoolOpt false "Enable immich";
  };

  # Fix until immich is in stable
  disabledModules = [ "services/web-apps/immich.nix" ];
  imports = [
    "${inputs.nixpkgs-unstable}/nixos/modules/services/web-apps/immich.nix"
  ];

  config = mkIf cfg.enable { 
	services.immich = {
		enable = true;

		port = 3001;
		package = inputs.nixpkgs-unstable.immich;
		host = "localhost";
	};
  };
}
