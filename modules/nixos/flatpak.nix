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
      "app.zen_browser.zen"
      "com.brave.Browser"
      "md.obsidian.Obsidian"
      "org.gnome.Loupe"
      "org.onlyoffice.desktopeditors"
      "org.flameshot.Flameshot"
      "org.gnome.Showtime"
      "org.gnome.Papers"
    ];
  };

  # Force Electron-based Flatpaks to use native Wayland instead of XWayland.
  # XWayland adds latency and causes Electron apps to crash on niri.
  system.activationScripts.flatpakOverrides = {
    text = ''
      ${pkgs.flatpak}/bin/flatpak override --user --socket=wayland \
        --env=ELECTRON_OZONE_PLATFORM_HINT=auto \
        md.obsidian.Obsidian || true
    '';
    deps = [];
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
