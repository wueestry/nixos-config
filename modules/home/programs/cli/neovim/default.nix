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
    home.packages = (
      with pkgs;
      [
        opencode
      ]
    );
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      #plugins = with pkgs.vimPlugins; [];

      extraPackages = with pkgs; [
        # LSPs
        luajitPackages.lua-lsp
        nil
        pyright

        # Formatter
        stylua
        ruff
        nixfmt-rfc-style
        prettierd

        # Languages and Compiler
        gcc
        python3
        nodejs_24
        cargo
        rustc
        cmake
        gnumake
        clang-tools

        ripgrep
        fzf

        fd

        texliveSmall

        tree-sitter
      ];
    };
    #xdg.configFile."nvim" = {
    #  source = config.lib.file.mkOutOfStoreSymlink ./config;
    #  recursive = true;
    #};
  };
}
