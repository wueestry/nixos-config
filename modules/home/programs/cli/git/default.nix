{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.programs.cli.git;
  home = config.${namespace}.config.user;
in
{
  options.${namespace}.programs.cli.git = with types; {
    enable = mkBoolOpt false "${namespace}.programs.git.enable";
    username = mkOpt str home.fullName "${namespace}.programs.git.username";
    useremail = mkOpt str home.email "${namespace}.programs.git.useremail";
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
