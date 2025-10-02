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
  cfg = config.${namespace}.services.navidrome;
in
{
  options.${namespace}.services.navidrome = with types; {
    enable = mkBoolOpt false "Enable navidrome";
  };

  config = mkIf cfg.enable {
    sops.secrets = {
      last-fm-key = {
        owner = "navidrome";
      };
      last-fm-secret = {
        owner = "navidrome";
      };
    };

    services.navidrome = {
      enable = true;
      settings = {
        Address = "0.0.0.0";
        Port = 4533;
        MusicFolder = "/mnt/data/navidrome/music";
        Deezer.Enabled = true;
      };
    };
    services.mopidy = {
      enable = true;
      #dataDir = "/mnt/data/navidrome/music";
      extensionPackages = ( with pkgs; [
        mopidy-mpd
        mopidy-local
        mopidy-spotify
      ]);
      configuration = ''
        [mpd]
        enabled = true
        hostname = ::
        port = 6600

        [file]
        enabled = true
        media_dirs = /mnt/data/navidrome/music
        show_dotfiles = false
        excluded_file_extensions =
          .jpg
          .jpeg
        metadata_timeout = 1000

        [spotify]
        client_id = b48a6d9-dd3c-4225-b158-54716843e7be
        client_secret = JAbgeem9MBG3QmPFjGrOGrWU209bnsQxueJ4kKumGqc
      '';
      #configuration = "
      #[proxy]
      #scheme = http
      #hostname = localhost
      #port = 6066
      #username = wueestry
      #passowrd = test

      #[spotify]
      #client_id = 3b48a6d9-dd3c-4225-b158-54716843e7be
      #client_secret = JAbgeem9MBG3QmPFjGrOGrWU209bnsQxueJ4kKumGqc=

      #[mpd]
      #enabled = true
      #hostname = 0.0.0.0
      #port = 6600
      #";
    };
  };
}
