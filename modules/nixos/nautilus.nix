{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.nautilus ];
  services.gvfs.enable = true;
}
