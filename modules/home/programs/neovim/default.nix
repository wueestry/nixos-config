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
  cfg = config.${namespace}.programs.neovim;
  nvim_config = pkgs.fetchFromGitHub {
    owner = "wueestry";
    repo = "neovim-config";
    rev = "a7d654888673961bb58306f880cc1921650d0f6b";
    hash = "sha256-0PiddTy7Mpm8Bnuatm6sRY4eZoCXuxMugJ0DNXk7JEM=";
  };
in
{
  options.${namespace}.programs.neovim = {
    enable = mkBoolOpt false "${namespace}.programs.neovim.enable";
  };
  config = mkIf cfg.enable {
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
        ruff-lsp
        pyright

        # Formatter
        stylua
        ruff
        nixfmt-rfc-style

        # Languages and Compiler
        gcc
        python3
        nodejs
        cargo
        rustc
      ];
    };
    xdg.configFile."nvim" = {
      source = "${nvim_config}";
    };
  };
}
