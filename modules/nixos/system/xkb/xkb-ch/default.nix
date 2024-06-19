{ config, lib, namespace, ... }:
with lib;
with lib.${namespace};
let cfg = config.${namespace}.config.xkb.xkb-ch;
in {
  options.${namespace}.config.xkb.xkb-ch = {
    enable = mkBoolOpt false "${namespace}.config.xkb.xkb-ch.enable";
  };

  config = mkIf cfg.enable {
    
    services.xserver.xkb = {
        layout = "ch";
    };
  };
}