{
  config,
  lib,
  osConfig,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
{
  snowfallorg.user.enable = true;
  zeus = {
    bundles = {
      development = enabled;
    };
    programs = {
      eza = enabled;
      git = {
        enable = true;
        username = "Ryan Wüest";
      };
      kitty = enabled;
      neovim = enabled;
      zsh = enabled;
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = lib.mkDefault (osConfig.system.stateVersion or "24.05");
}
