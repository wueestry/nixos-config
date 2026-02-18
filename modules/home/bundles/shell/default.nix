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
  cfg = config.${namespace}.bundles.shell;
in
{
  options.${namespace}.bundles.shell = with types; {
    enable = mkBoolOpt false "Enable shell bundle";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      yazi
      btop
      coreutils
      killall
      tldr
      wget
      curl

      ripgrep

      unrar
      unzip
      zip

      fastfetch

      # Config formatting
      nixfmt-rfc-style
    ];
    olympus = {
      programs = {
        cli = {
          atuin = enabled;
          eza = enabled;
          fzf = enabled;
          starship = enabled;
          zoxide = enabled;
          zsh = enabled;
          lazygit = enabled;
          neovim = enabled;
          tmux = enabled;
        };
        gui = {
          kitty = enabled;
        };
      };
    };
  };
}
