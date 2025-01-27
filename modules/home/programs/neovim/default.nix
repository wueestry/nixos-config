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
    rev = "d99df6c377695f50568a87bba444b0eac10c0746";
    hash = "sha256-nFTHIwF1DKrYgpACM/m9jndW4CqqGOqoBheJHtzXTrk=";
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
        cmake
        clang-tools

        ripgrep
        fzf
      ];
    };
    # xdg.configFile."nvim" = {
    #   source = "${nvim_config}";
    # };
  };
}
