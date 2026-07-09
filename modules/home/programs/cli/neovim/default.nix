{
  config,
  pkgs,
  lib,
  namespace,
  inputs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.programs.cli.neovim;
in
{
  options.${namespace}.programs.cli.neovim = {
    enable = mkBoolOpt false "${namespace}.programs.neovim.enable";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      opencode
    ];
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      extraPackages = with pkgs; [
        # LSPs
        luajitPackages.lua-lsp
        nil
        pyright

        # Formatters
        stylua
        ruff
        nixfmt-rfc-style
        prettierd

        # Generic tools used by plugins/LSPs
        ripgrep
        fzf
        fd
        tree-sitter
      ];
    };
  };
}
