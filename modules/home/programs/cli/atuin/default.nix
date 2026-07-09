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
  cfg = config.${namespace}.programs.cli.atuin;
in
{
  options.${namespace}.programs.cli.atuin = with types; {
    enable = mkBoolOpt false "Enable atuin";
  };

  config = mkIf cfg.enable {
    programs.atuin = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
