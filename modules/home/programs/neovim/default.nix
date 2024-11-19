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
in
{
  options.${namespace}.programs.neovim = {
    enable = mkBoolOpt false "${namespace}.programs.neovim.enable";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      fzf
      nodejs
      ripgrep
    ];
    programs.neovim = {
    	enable = true;
	defaultEditor = true;
	plugins = [
	  {
		plugin = pkgs.vimPlugins.LazyVim;
	  }
	];
    };
  };
}
