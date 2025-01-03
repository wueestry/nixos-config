{
  stdenv,
  lib,
  fetchFromGitHub,
  buildGoModule,
  buildNpmPackage,
  pkgs,
}:
let
  pname = "wanderer";
  version = "0.12.0";

  wanderer_src = fetchFromGitHub {
    owner = "Flomp";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-Q/6SwQmAi1qTVfnHmUX/Xcc5wmSei8JOue53W1uKuwo=";
  };
in
buildNpmPackage {
  inherit pname version;

  src = wanderer_src;

  buildInputs = [
    pkgs.meilisearch
  ];

  configurePhase = ''
    	export PUBLIC_VALHALLA_URL=https://valhalla1.openstreetmap.de
  '';

  npmDepsHash = "sha256-eS8avHhU7FLke43HhtAktVPyLEoTJyk1LunpaO1T6dQ=";

  npmBuildScript = "build";

  npmInstallFlags = "--omit=web";

  sourceRoot = "${wanderer_src.name}/web";
}
