{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    sops
    age
    ssh-to-age
  ];
}
