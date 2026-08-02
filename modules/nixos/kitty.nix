{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    kitty
    xdg-terminal-exec
  ];
}
