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
