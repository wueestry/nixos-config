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
  cfg = config.${namespace}.services.ollama;
  alpaca-cuda = pkgs.alpaca.override {
    ollama = pkgs.ollama-cuda;
  };
in
{
  options.${namespace}.services.ollama = with types; {
    enable = mkBoolOpt false "Enable ollama";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      alpaca-cuda
    ];
  };
}
