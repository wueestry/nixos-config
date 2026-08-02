{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    atuin
    cmake
    fzf
    gcc
    lazygit
    python3
    ripgrep
    stow
  ];
}
