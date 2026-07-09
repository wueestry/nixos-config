{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.services.polkit-gnome;
in
{
  options.${namespace}.services.polkit-gnome = with types; {
    enable = mkBoolOpt false "Enable gnome polkit authentication agent";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      polkit_gnome
      libsecret
    ];

    programs.seahorse.enable = true;

    security = {
      polkit.enable = true;
    };

    services.gnome.gnome-keyring.enable = true;

    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
