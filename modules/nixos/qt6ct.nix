{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.qt6Packages.qt6ct ];
  environment.variables.QT_QPA_PLATFORMTHEME = "qt6ct";
}
