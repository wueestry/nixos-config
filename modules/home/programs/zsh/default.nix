{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.programs.zsh;
in {
  options.${namespace}.programs.zsh = {
    enable = mkBoolOpt false "${namespace}.programs.zsh.enable";
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;

      initExtraBeforeCompInit = ''
        # p10k instant prompt
        P10K_INSTANT_PROMPT="$XDG_CACHE_HOME/p10k-instant-prompt-''${(%):-%n}.zsh"
        [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"
      '';

      initExtra = ''
        # Fix an issue with tmux.
        export KEYTIMEOUT=1

        # Use vim bindings.
        set -o vi
      '';

      shellAliases = {};

      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          file = "p10k.zsh";
          name = "powerlevel10k-config";
          src = ./p10k;
        }
      ];
    };
  };
}
