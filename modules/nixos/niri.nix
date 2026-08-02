{ pkgs, ... }:
{
  programs.niri.enable = true;

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
