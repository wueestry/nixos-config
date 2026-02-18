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

  networking.hostName = "ares";

  olympus = {
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
      gpu.nvidia = enabled;
    };
    programs = {
      flatpak = {
        core = enabled;
        brave = enabled;
        spotify = enabled;
      };
      gaming.steam = enabled;
      security.sops = enabled;
      system = {
        nh = enabled;
        nix-ld = enabled;
      };
    };
    services = {
      virtualisation.virtualisation = enabled;
    };
    system = {
      boot.grub = enabled;
      xkb.xkb-us = enabled;
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
