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
    rev = "a3b788a2d3e9db10546c487fca4e29a73bdfd372";
    hash = "sha256-4nOlnvN3v/jYAhFI5dvbw3YVs41U/zihhiAEsrAqVu0=";
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
