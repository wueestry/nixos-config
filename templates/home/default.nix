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
  olympus = {
    config.xdg = enabled;

    # Uncomment once desktop.niri is enabled on the matching system:
    # desktop.niri = enabled;
    # bundles.shell = enabled;
  };

  home.stateVersion = lib.mkDefault (osConfig.system.stateVersion or "24.05");
}
