{ config, lib, namespace, ... }:
with lib;
with lib.${namespace};
let cfg = config.${namespace}.config.home;
in {
  options.${namespace}.config.home = with types; {
    username = mkOpt str (config.snowfallorg.user.name or "ryan")
      "${namespace}.config.home.username";
    useremail = mkOpt str "ryan.wueest@protonmail.com" "${namespace}.config.home.useremail";
  };

  config = {
    home = {
      username = mkDefault cfg.username;
      homeDirectory = mkDefault "/home/${cfg.username}";
    };
  };
}