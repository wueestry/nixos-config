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
    enable = mkBoolOpt false "Whether or not to enable common configuration.";
  };

  config = mkIf cfg.enable {
    services = {
      udisks2.enable = true; # Required for e-reader connections to calibre
      xserver.enable = true;
    };
    zeus = {
      config.nix = enabled;

      hardware = {
        audio = enabled;
        networking = enabled;
      };

      programs = {
        stylix = enabled;
      };

      services = {
        printing = enabled;
        tailscale = enabled;
      };

      system = {
        boot = enabled;
        fonts = enabled;
        locale = enabled;
      };
    };
  };
}
