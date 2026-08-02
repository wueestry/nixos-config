{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    fzf
    lazygit
    ripgrep
    stow
  ];
}
