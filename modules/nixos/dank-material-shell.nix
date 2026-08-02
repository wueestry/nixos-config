{ pkgs, inputs, ... }:
{
  programs.dms-shell = {
    enable = true;
    package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
    enableSystemMonitoring = true;
    enableDynamicTheming = true;
  };
}
