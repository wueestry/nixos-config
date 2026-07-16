{ inputs, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./microvm.nix
    inputs.nixos-hardware.nixosModules.lenovo-yoga-7-14ARH7-nvidia
  ];

  networking.hostName = "athena";

  # The NVIDIA driver pulled in by the hardware module above is unfree.
  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.ryan = {
    isNormalUser = true;
    description = "Ryan";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  system.stateVersion = "26.05";
}
