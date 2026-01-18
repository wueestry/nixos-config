{
  options,
  config,
  lib,
  pkgs,
  namespace,
  inputs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.services.ollama;
in
{
  options.${namespace}.services.ollama = with types; {
    enable = mkBoolOpt false "Enable ollama";
  };

  config = mkIf cfg.enable {
    sops.secrets = {
      litellm-master-key = {};
      litellm-salt-key = {};
    };
    services = {
      ollama = {
        enable = true;
        port = 11434;
        host = "0.0.0.0";
        acceleration = "cuda";
      };
      #nextjs-ollama-llm-ui = {
      #  enable = true;
      #  ollamaUrl = "http://127.0.0.1:11434";
      #  hostname = "0.0.0.0";
      #  port = 3050;
      #};
      open-webui = {
        enable = true;
        port = 3050;
        host = "0.0.0.0";
      };
      litellm = {
        enable = false;
        port = 11111;
        host = "0.0.0.0";
        settings.environment_variables = {
          LITELLM_MASTER_KEY="$(cat ${config.sops.secrets.litellm-master-key.path})";
          LITELLM_SALT_KEY="$(cat ${config.sops.secrets.litellm-salt-key.path})";
        };
      };
    };
  };
}
