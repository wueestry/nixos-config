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

  zeus = {
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
      nvidia = enabled;
    };
    services = {
      ssh = enabled;
      tailscale = enabled;
      virtualisation = enabled;

      immich = enabled;
      mealie = enabled;
      jellyfin = disabled;
      stirling-pdf = enabled;
      firefly-iii = enabled;
      nextcloud = enabled;
      audiobookshelf = enabled;
      calibre = enabled;
      wanderer = enabled;
      ollama = enabled;
      navidrome = enabled;
      syncthing = enabled;

      homepage-dashboard = enabled;
    };
    system = {
      boot.systemd-boot = enabled;
      xkb.xkb-us = enabled;
      locale = enabled;
    };
    programs = {
      sops = enabled;
      nh = enabled;
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
