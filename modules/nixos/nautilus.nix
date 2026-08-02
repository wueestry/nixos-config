{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.nautilus
    pkgs.file-roller  # archive manager; integrates into Nautilus right-click menu
  ];
  services.gvfs.enable = true;
}
