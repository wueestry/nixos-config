{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.programs.system.nix-ld;
in
{
  options.${namespace}.programs.system.nix-ld = {
    enable = mkBoolOpt false "${namespace}.programs.nix-ld.enable";
  };

  config = mkIf cfg.enable {
    programs.nix-ld = {
      enable = true;
    };
  };
}
