{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.programs.tmux;
in {
  options.${namespace}.programs.tmux = with types; {
    enable = mkBoolOpt false "Enable programs.tmux";
  };

  config =
    mkIf cfg.enable {
        programs.tmux = {
            enable = true;
            mouse = true;
            shell = "${pkgs.zsh}/bin/zsh";
            prefix = "C-s";
            terminal = "kitty";
            keyMode = "vi";

            extraConfig = ''
            bind-key h select-pane -L
            bind-key j select-pane -D
            bind-key k select-pane -U
            bind-key l select-pane -R

            set -gq allow-passthrough on
            bind-key x kill-pane # skip "kill-pane 1? (y/n)" prompt
            set -g detach-on-destroy off  # don't exit from tmux when closing a session

            bind-key -n C-Tab next-window
            bind-key -n C-S-Tab previous-window
            bind-key -n M-Tab new-window
            '';

            plugins = with pkgs; [
                tmuxPlugins.catppuccin
                tmuxPlugins.vim-tmux-navigator
                tmuxPlugins.resurrect
                tmuxPlugins.sensible
            ];
        };
    };
}
