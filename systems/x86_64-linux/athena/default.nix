{
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; {
  imports = [
    ./hardware.nix
  ];

  zeus = {
    config = {
        user.name = "ryan";
    };
     bundles = {
      common = enabled;
    };
    desktop.kde = enabled;
    programs = {
        nh = enabled;
        nix-ld = enabled;
    };
    system = {
        xkb.xkb-ch = enabled;
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
