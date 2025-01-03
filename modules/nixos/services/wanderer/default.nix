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
  cfg = config.${namespace}.services.wanderer;
  wanderer_startup = pkgs.writeShellScriptBin "wanderer_startup" ''
    meilisearch --master-key $MEILI_MASTER_KEY &
    ${pkgs.zeus.wanderer_pocketbase}/bin/pocketbase serve &
    cd ${pkgs.zeus.wanderer}/bin/build  && node build &

    wait
  '';
  meili_key = "8MjSmA7Smu2N7qk6axgeeduHEqWmEgB7"; # "$(sudo cat /run/secrets/meili-master-key)";
in
{
  options.${namespace}.services.wanderer = with types; {
    enable = mkBoolOpt false "Enable wanderer";
  };

  config = mkIf cfg.enable {
    sops.secrets.meili-master-key = { };
    environment = {
      sessionVariables = {
        MEILI_MASTER_KEY = meili_key;
      };
      variables = {
        ORIGIN = "http://localhost:3000";
        MEILI_URL = "http://127.0.0.1:7700";
        PUBLIC_POCKETBASE_URL = "http://127.0.0.1:7090";
        PUBLIC_VALHALLA_URL = "https://valhalla1.openstreetmap.de";
      };
      systemPackages = with pkgs; [
        meilisearch
        zeus.wanderer
        zeus.wanderer_pocketbase
        wanderer_startup
      ];
    };
  };
}
