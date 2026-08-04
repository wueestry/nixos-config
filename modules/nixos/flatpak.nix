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

  # Enable native Wayland for Obsidian so focus works when launched from
  # layer-shell launchers (like DMS). XWayland fails because xwayland-satellite
  # needs a focused toplevel to hand focus to a new X11 window — the DMS
  # launcher is a layer surface, not a toplevel, so focus always fails and
  # Obsidian exits. Native Wayland handles focus through the compositor directly.
  # --system is required because the flatpak is installed system-wide.
  system.activationScripts.flatpakOverrides = {
    text = ''
      ${pkgs.flatpak}/bin/flatpak override --system \
        --socket=wayland \
        --env=ELECTRON_OZONE_PLATFORM_HINT=auto \
        md.obsidian.Obsidian || true
    '';
    deps = [];
  };

  # Disable Electron's inner renderer sandbox so zypak doesn't GPF when
  # launched from a systemd scope (DMS uses systemd-run). The flatpak bwrap
  # sandbox still isolates the app.
  system.activationScripts.obsidianFlags = {
    text = ''
      FLAGS_DIR="/home/ryan/.var/app/md.obsidian.Obsidian/config/obsidian"
      mkdir -p "$FLAGS_DIR"
      echo "--no-sandbox" > "$FLAGS_DIR/user-flags.conf"
    '';
    deps = [];
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
