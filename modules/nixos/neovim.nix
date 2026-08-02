{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.neovim ];
  environment.variables.EDITOR = "nvim";
}
