{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.programs.zsh;
in
{
  options.${namespace}.programs.zsh = {
    enable = mkBoolOpt false "${namespace}.programs.zsh.enable";
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;

      autosuggestion.enable = true;
      enableCompletion = true;
      historySubstringSearch.enable = true;
      syntaxHighlighting.enable = true;

      initExtra = ''
                # Fix an issue with tmux.
                export KEYTIMEOUT=1

                # Use vim bindings.
                set -o vi

        	export EDITOR="nvim"
      '';

      shellAliases = {
        vim = "nvim";
        vi = "nvim";
        v = "nvim";
        z = "cd";
        ls = "eza --icons=always --no-quotes";
        tree = "eza --icons=always --tree --no-quotes";
      };

      plugins = [ ];
    };
  };
}
