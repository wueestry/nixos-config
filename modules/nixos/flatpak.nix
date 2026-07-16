# Flatpak apps run in their own bubblewrap sandbox with portal-mediated
# file/network access, so prefer installing network-facing or otherwise
# risky apps (browsers, chat clients, PDF viewers) here instead of via
# environment.systemPackages.
{ pkgs, ... }:

{
  services.flatpak = {
    enable = true;

    remotes = [
      { name = "flathub"; location = "https://flathub.org/repo/flathub.flatpakrepo"; }
    ];

    packages = [
      "org.mozilla.firefox"
    ];
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
