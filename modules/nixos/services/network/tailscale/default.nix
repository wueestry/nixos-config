{
  lib,
  pkgs,
  config,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.services.network.tailscale;
in
{
  options.${namespace}.services.network.tailscale = with types; {
    enable = mkBoolOpt false "Whether or not to configure Tailscale";
    autoconnect = {
      enable = mkBoolOpt false "Whether or not to enable automatic connection to Tailscale";
      key = mkOpt str "" "The authentication key to use";
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.autoconnect.enable -> cfg.autoconnect.key != "";
        message = "${namespace}.services.network.tailscale.autoconnect.key must be set";
      }
    ];

    environment.systemPackages = with pkgs; [ tailscale ];

    services.tailscale = enabled;

    networking = {
      firewall = {
        trustedInterfaces = [ config.services.tailscale.interfaceName ];

        allowedUDPPorts = [ config.services.tailscale.port ];

        checkReversePath = "loose";
      };

      networkmanager.unmanaged = [ "tailscale0" ];
    };

    systemd.services.tailscale-autoconnect = mkIf cfg.autoconnect.enable {
      description = "Automatic connection to Tailscale";

      after = [
        "network-pre.target"
        "tailscale.service"
      ];
      wants = [
        "network-pre.target"
        "tailscale.service"
      ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig.Type = "oneshot";

      script = with pkgs; ''
        sleep 2

        status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
        if [ $status = "Running" ]; then
          exit 0
        fi

        ${tailscale}/bin/tailscale up -authkey "${cfg.autoconnect.key}"
      '';
    };
  };
}
