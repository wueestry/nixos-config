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
  cfg = config.${namespace}.programs.zen;
in
{
  options.${namespace}.programs.zen = with types; {
    enable = mkBoolOpt false "Enable module";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      inputs.zen-browser.packages."${system}".default
    ];
  };
}
