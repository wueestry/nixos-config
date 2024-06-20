{
  config,
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.programs.neovim;
  toLua = str: ''
    lua << EOF
    ${str}
    EOF
  '';
  toLuaFile = file: ''
    lua << EOF
    ${builtins.readFile file}
    EOF
  '';
in {
  options.${namespace}.programs.neovim = {
    enable = mkBoolOpt false "${namespace}.programs.neovim.enable";
  };
  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;

      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
  };
}
