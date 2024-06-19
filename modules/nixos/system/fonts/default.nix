{ config, lib, pkgs, namespace, ... }:
with lib;
with lib.${namespace};
let cfg = config.${namespace}.config.fonts;
in {
  options.${namespace}.config.fonts = {
    enable = mkBoolOpt false "${namespace}.config.fonts.enable";
  };

  config = mkIf cfg.enable { 
    fonts = {
        enableDefaultPackages = true; 
        packages = with pkgs; [
            jetbrains-mono
            meslo-lgs-nf
            noto-fonts
            roboto
            corefonts
        ];
    };
    };
}