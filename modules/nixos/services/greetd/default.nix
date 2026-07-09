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
  cfg = config.${namespace}.services.greetd;
in
{
  options.${namespace}.services.greetd = with types; {
    enable = mkBoolOpt false "Enable greetd with the regreet graphical greeter";
  };

  config = mkIf cfg.enable {
    # `programs.regreet` wires up services.greetd + cage for us.
    programs.regreet = {
      enable = true;
      cageArgs = [
        "-s"
      ];
    };
  };
}
