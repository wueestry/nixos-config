{
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
{
  imports = [ ./hardware.nix ];

  networking.hostName = "changeme";

  olympus = {
    config.user = {
      name = "changeme";
      extraGroups = [
        "networkmanager"
        "wheel"
        "audio"
        "video"
      ];
    };

    bundles.common = enabled;

    # Uncomment to bring up the niri + noctalia desktop on this host.
    # desktop.niri = enabled;

    system = {
      boot.systemd-boot = enabled;
      xkb.xkb-us = enabled;
    };
  };

  # ======================== DO NOT CHANGE THIS ========================
  system.stateVersion = "24.05";
  # ======================== DO NOT CHANGE THIS ========================
}
