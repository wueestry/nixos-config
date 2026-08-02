{ pkgs, inputs, ... }:
{
  programs.dms-shell = {
    enable = true;
    package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
    enableSystemMonitoring = true;
    enableDynamicTheming = true;
  };

  programs.dsearch.enable = true;

  # adw-gtk3 is required by DMS dynamic theming: it sets the gsettings gtk-theme
  # to "adw-gtk3" / "adw-gtk3-dark" when applying matugen colours.
  environment.systemPackages = [ pkgs.adw-gtk3 ];
}
