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
  cfg = config.${namespace}.services.network.ssh;
in
{
  options.${namespace}.services.network.ssh = with types; {
    enable = mkBoolOpt false "Enable ssh";
  };

  config = mkIf cfg.enable {
    services.network.openssh.enable = true;
    environment.systemPackages = [
      pkgs.sshs
    ];
  };
}
