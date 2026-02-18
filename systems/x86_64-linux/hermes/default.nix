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

  networking.hostName = "hermes";

  # logind
  services.logind.extraConfig = ''
    HandlePowerKey=ignore
    HandleLidSwitch=ignore
    HandleLidSwitchExternalPower=ignore
  '';

  boot.swraid.enable = true;
  networking.firewall.enable = false;

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
    hardware.networking = enabled;
    services = {
      network = {
        ssh = enabled;
        tailscale = enabled;
      };

      home-automation.immich = enabled;
    };
    system = {
      boot.systemd-boot = enabled;
      xkb.xkb-ch = enabled;
      locale = enabled;
    };
    programs = {
      security.sops = enabled;
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
