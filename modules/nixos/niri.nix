{ pkgs, ... }:
{
  programs.niri.enable = true;

  # xwayland-satellite bridges X11 apps (including X11-only Flatpaks) into the
  # Wayland session without requiring a full XWayland-aware compositor.
  systemd.user.services.xwayland-satellite = {
    description = "XWayland satellite for niri";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.xwayland-satellite}/bin/xwayland-satellite";
      # Propagate DISPLAY to all subsequent user services and terminals.
      ExecStartPost = "${pkgs.systemd}/bin/systemctl --user set-environment DISPLAY=:0";
      Restart = "on-failure";
      RestartSec = "3s";
    };
  };

  # Wayland clipboard contents are owned by the source app and vanish when it
  # loses focus; wl-clip-persist keeps them alive across focus changes.
  systemd.user.services.wl-clip-persist = {
    description = "Persist Wayland clipboard contents across focus changes";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.wl-clip-persist}/bin/wl-clip-persist --clipboard both";
      Restart = "on-failure";
      RestartSec = "3s";
    };
  };
}
