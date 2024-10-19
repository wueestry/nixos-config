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

  networking.hostName = "athena";

  # logind
  services.logind.extraConfig = ''
    HandlePowerKey=ignore
    HandleLidSwitch=suspend
    HandleLidSwitchExternalPower=ignore
  '';

  zeus = {
    config = {
      user = {
        name = "ryan";
        extraGroups = [
          "networkmanager"
          "wheel"
          "audio"
          "video"
          "libvirtd"
          "docker"
        ];
      };
    };
    bundles = {
      common = enabled;
    };
    desktop.hyprland = enabled;
    hardware = {
      bluetooth = enabled;
      cuda = enabled;
    };
    programs = {
      nh = enabled;
      nix-ld = enabled;
      steam = enabled;
    };
    services = {
      virtualisation = enabled;
    };
    system = {
      boot.systemd-boot = enabled;
      xkb.xkb-ch = enabled;
    };
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05";
}
