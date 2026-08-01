{ pkgs, ... }:

{
  home.packages = [
    pkgs.fzf
    pkgs.ripgrep
    pkgs.stow
  ];
}
