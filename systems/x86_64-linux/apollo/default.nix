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

  networking.hostName = "apollo";

  boot.swraid.enable = true;

  olympus = {
    config = {
      user = {
        name = "wueestry";
        extraGroups = [
          "networkmanager"
          "wheel"
          "audio"
          "video"
          "libvirtd"
          "docker"
          "render"
        ];
      };
      nix = enabled;
    };
    hardware = {
      cuda = enabled;
      gpu.nvidia = enabled;
    };
    services = {
      network = {
        ssh = enabled;
        tailscale = enabled;
      };
      virtualization = {
        virtualisation = enabled;
        docker = {
          garmin-grafana = disabled;
        };
      };

      media = {
        audiobookshelf = enabled;
        jellyfin = disabled;
        navidrome = enabled;
        nextcloud = enabled;
      };

      home-automation = {
        firefly-iii = enabled;
        immich = enabled;
        mealie = enabled;
        readeck = enabled;
      };

      monitoring = {
        grafana = disabled;
      };

      network.syncthing = enabled;
      network.stirling-pdf = enabled;
      media.calibre = enabled;
      media.ollama = enabled;
      home-automation.homepage-dashboard = enabled;
    };
    system = {
      boot.systemd-boot = enabled;
      xkb.xkb-us = enabled;
      locale = enabled;
    };
    programs = {
      security.sops = enabled;
      system.nh = enabled;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05";
}
