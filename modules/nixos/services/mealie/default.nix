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
  cfg = config.${namespace}.services.mealie;
in
{
  disabledModules = [ "services/web-apps/mealie.nix" ];
  imports = [ "${inputs.unstable}/nixos/modules/services/web-apps/mealie.nix" ];

  options.${namespace}.services.mealie = with types; {
    enable = mkBoolOpt false "Enable mealie";
  };

  config = mkIf cfg.enable {
    services.mealie = {
      enable = true;
      package = inputs.unstable.legacyPackages.x86_64-linux.mealie;
      port = 8088;
      listenAddress = "0.0.0.0";
      settings = {
        TZ = "Europe/Zurich";
      };
    };
  };
}
