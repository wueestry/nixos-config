{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.config.apps;
in
{
  options.${namespace}.config.apps = with types; {
    enable = mkBoolOpt false "Enable default app config";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.papers ];

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "org.gnome.Papers.desktop";
        "text/html" = "com.zen_browser.zen.desktop";
        "x-scheme-handler/http" = "com.zen_browser.zen.desktop";
        "x-scheme-handler/https" = "com.zen_browser.zen.desktop";
        "x-scheme-handler/about" = "com.zen_browser.zen.desktop";
        "x-scheme-handler/unknown" = "com.zen_browser.zen.desktop";
      };
    };
  };
}
