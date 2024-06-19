{ config, lib, namespace,... }:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.programs.git;
  home = config.${namespace}.config.home;
in {
  options.${namespace}.programs.git = with types; {
    enable = mkBoolOpt false "${namespace}.programs.git.enable";
    username = mkOpt str home.username "${namespace}.programs.git.username";
    useremail = mkOpt str home.useremail "${namespace}.programs.git.useremail";
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      delta = enabled;
      extraConfig = {
        pull.rebase = true;
        init.defaultBranch = "main";
        rebase.autoStash = true;
      };
      lfs = enabled;
      userEmail = cfg.useremail;
      userName = cfg.username;
    };
  };
}