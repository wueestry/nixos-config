{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.programs.system.nh;
  user = config.${namespace}.config.user;
in
{
  options.${namespace}.programs.system.nh = {
    enable = mkBoolOpt false "${namespace}.programs.system.nh.enable";
  };

  config = mkIf cfg.enable {
    programs.nh = {
      enable = true;
      #flake = "~/.nixcfg";
    };
  };
}
