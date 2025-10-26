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
  cfg = config.${namespace}.bundles.common;
  unstable = import inputs.unstable {
    inherit (pkgs) system;  # reuse system type from pkgs
    config.allowUnfree = true;
  };
in
{
  options.${namespace}.bundles.common = with types; {
    enable = mkBoolOpt false "Whether or not to enable common configuration.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = (with pkgs;[
      unstable.winboat
    ]);
    services = {
      udisks2.enable = true; # Required for e-reader connections to calibre
      gvfs.enable = true;
      xserver = {
        enable = true;
        excludePackages = [ pkgs.xterm ];
      };
    };
    zeus = {
      config.nix = enabled;

      hardware = {
        audio = enabled;
        networking = enabled;
      };

      programs = {
        sops = enabled;
      };

      services = {
        printing = enabled;
        tailscale = enabled;
      };

      system = {
        fonts = enabled;
        locale = enabled;
      };
    };
  };
}
