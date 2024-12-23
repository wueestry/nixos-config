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
in
{
  options.${namespace}.wanderer = with types; {
    enable = mkBoolOpt false "Enable wanderer";
  };

  config = mkIf cfg.enable {
    # Auto-generated using compose2nix

    # Runtime
    virtualisation.podman = {
      enable = true;
      autoPrune.enable = true;
      dockerCompat = true;
      defaultNetwork.settings = {
        # Required for container networking to be able to use names.
        dns_enabled = true;
      };
    };
    # Containers
    virtualisation.oci-containers.containers."wanderer-db" = {
      image = "flomp/wanderer-db";
      environment = {
        "MEILI_MASTER_KEY" = "vODkljPcfFANYNepCHyDyGjzAMPcdHnrb6X5KyXQPWo";
        "MEILI_URL" = "http://search:7700";
      };
      volumes = [
        "/mnt/storage/wanderer/data/pb_data:/pb_data:rw"
      ];
      ports = [
        "7090:8090/tcp"
      ];
      dependsOn = [
        "wanderer-search"
      ];
      log-driver = "journald";
      extraOptions = [
        "--network-alias=db"
        "--network=wanderer_wanderer"
      ];
    };
    systemd.services."podman-wanderer-db" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "always";
      };
      after = [
        "podman-network-wanderer_wanderer.service"
      ];
      requires = [
        "podman-network-wanderer_wanderer.service"
      ];
      partOf = [
        "podman-compose-wanderer-root.target"
      ];
      wantedBy = [
        "podman-compose-wanderer-root.target"
      ];
    };
    virtualisation.oci-containers.containers."wanderer-search" = {
      image = "flomp/wanderer-search";
      environment = {
        "MEILI_MASTER_KEY" = "vODkljPcfFANYNepCHyDyGjzAMPcdHnrb6X5KyXQPWo";
        "MEILI_NO_ANALYTICS" = "true";
        "MEILI_URL" = "http://search:7700";
      };
      volumes = [
        "/mnt/storage/wanderer/data/data.ms:/meili_data/data.ms:rw"
      ];
      ports = [
        "7700:7700/tcp"
      ];
      log-driver = "journald";
      extraOptions = [
        "--health-cmd=curl --fail http://localhost:7700/health || exit 1"
        "--health-interval=15s"
        "--health-retries=10"
        "--health-start-period=20s"
        "--health-timeout=10s"
        "--network-alias=search"
        "--network=wanderer_wanderer"
      ];
    };
    systemd.services."podman-wanderer-search" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "always";
      };
      after = [
        "podman-network-wanderer_wanderer.service"
      ];
      requires = [
        "podman-network-wanderer_wanderer.service"
      ];
      partOf = [
        "podman-compose-wanderer-root.target"
      ];
      wantedBy = [
        "podman-compose-wanderer-root.target"
      ];
    };
    virtualisation.oci-containers.containers."wanderer-web" = {
      image = "flomp/wanderer-web";
      environment = {
        "BODY_SIZE_LIMIT" = "Infinity";
        "MEILI_MASTER_KEY" = "vODkljPcfFANYNepCHyDyGjzAMPcdHnrb6X5KyXQPWo";
        "MEILI_URL" = "http://search:7700";
        "ORIGIN" = "http://localhost:3000";
        "PUBLIC_DISABLE_SIGNUP" = "false";
        "PUBLIC_POCKETBASE_URL" = "http://db:7090";
        "PUBLIC_VALHALLA_URL" = "https://valhalla1.openstreetmap.de";
        "UPLOAD_FOLDER" = "/app/uploads";
      };
      volumes = [
        "/home/ryan/Developer/wanderer-nix/data/uploads:/app/uploads:rw"
      ];
      ports = [
        "3000:3000/tcp"
      ];
      dependsOn = [
        "wanderer-db"
        "wanderer-search"
      ];
      log-driver = "journald";
      extraOptions = [
        "--network-alias=web"
        "--network=wanderer_wanderer"
      ];
    };
    systemd.services."podman-wanderer-web" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "always";
      };
      after = [
        "podman-network-wanderer_wanderer.service"
      ];
      requires = [
        "podman-network-wanderer_wanderer.service"
      ];
      partOf = [
        "podman-compose-wanderer-root.target"
      ];
      wantedBy = [
        "podman-compose-wanderer-root.target"
      ];
    };

    # Networks
    systemd.services."podman-network-wanderer_wanderer" = {
      path = [ pkgs.podman ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStop = "podman network rm -f wanderer_wanderer";
      };
      script = ''
        podman network inspect wanderer_wanderer || podman network create wanderer_wanderer --driver=bridge
      '';
      partOf = [ "podman-compose-wanderer-root.target" ];
      wantedBy = [ "podman-compose-wanderer-root.target" ];
    };

    # Root service
    # When started, this will automatically create all resources and start
    # the containers. When stopped, this will teardown all resources.
    systemd.targets."podman-compose-wanderer-root" = {
      unitConfig = {
        Description = "Root target generated by compose2nix.";
      };
      wantedBy = [ "multi-user.target" ];
    };

  };
}
