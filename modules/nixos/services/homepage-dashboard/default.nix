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
  cfg = config.${namespace}.services.homepage-dashboard;
in
{
  options.${namespace}.services.homepage-dashboard = with types; {
    enable = mkBoolOpt false "Enable homepage-dashboard";
  };

  config = mkIf cfg.enable {
    services.homepage-dashboard = {
      enable = true;
      listenPort = 8082;
      settings = {
        background = "https://images.unsplash.com/photo-1730725469217-0832a94d7c2d?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
        color = "neutral";
	theme = "dark";
      };

      services = [
        {
          "Media Storage" = [
            {
              "Immich" = {
                description = "Self-hosted photo and video backup solution";
                icon = "immich.png";
                href = "http://apollo:3001";
              };
            }
            {
              "Jellyfin" = {
                description = "Free Software Media System";
                icon = "jellyfin.png";
                href = "http://apollo:8096";
              };

            }
          ];
        }
        {
          "Other" = [
            {
              "Mealie" = {
                description = "Self hosted recipe manager and meal planner";
                icon = "mealie.png";
                href = "http://apollo:8088";
              };
            }
            {
              "Firefly III" = {
                description = "A personal finances manager";
                icon = "firefly.png";
                href = "http://apollo:9080";
              };
            }
          ];
        }
        {
          "Tools" = [
            {
              "Stirling PDF" = {
                description = "A locally hosted web application that allows you to perform various operations on PDF files";
                icon = "stirling-pdf.png";
                href = "http://apollo:8001";
              };
            }
          ];
        }
      ];
    };
  };
}
