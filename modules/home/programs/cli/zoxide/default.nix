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
  cfg = config.${namespace}.programs.cli.zoxide;
in
{
  options.${namespace}.programs.cli.zoxide = with types; {
    enable = mkBoolOpt false "Enable programs.zoxide";
  };

  config = mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
