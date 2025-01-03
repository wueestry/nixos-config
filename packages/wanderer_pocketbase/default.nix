{
  stdenv,
  lib,
  fetchFromGitHub,
  buildGoModule,
  buildNpmPackage,
  pkgs,
}:
let
  pname = "wanderer_pocketbase";
  version = "0.12.0";

  wanderer_src = fetchFromGitHub {
    owner = "Flomp";
    repo = "wanderer";
    rev = "v${version}";
    hash = "sha256-Q/6SwQmAi1qTVfnHmUX/Xcc5wmSei8JOue53W1uKuwo=";
  };
in
buildGoModule {
  inherit pname version;

  vendorHash = "sha256-WF7Q/Aa0EK01X9XPt7trgP3KeOGzheLLDpNdyIiVzRA=";

  src = wanderer_src;

  sourceRoot = "${wanderer_src.name}/db";
}
