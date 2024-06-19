{ config, lib, pkgs, namespace, ... }:
with lib;
with lib.${namespace};
let cfg = config.${namespace}.config.user;
in {
  options.${namespace}.config.user = with types; {
    name = mkOpt str "ryan" "${namespace}.config.user.name";
  };

  config = {
    programs.zsh = enabled;
    users = {
      mutableUsers = mkForce false;
      users.${cfg.name} = {
        uid = 1000;
        shell = pkgs.zsh;
        extraGroups = [
          "wheel"
          "video"
          "audio"
          "networkmanager"
          "lp"
          "scanner"
          "kvm"
          "libvirtd"
        ];
        isNormalUser = true;
        initialPassword = "1234";
      };
    };
  };
}