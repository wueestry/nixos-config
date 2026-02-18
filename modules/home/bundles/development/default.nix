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
  cfg = config.${namespace}.bundles.development;
in
{
  options.${namespace}.bundles.development = with types; {
    enable = mkBoolOpt false "Enable development bundle";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      clang-tools
      cmake
      python3
      devenv
      nodePackages.prettier
      gnumake
    ];
  };
}
