{
  lib,
  inputs,
  namespace,
  pkgs,
  stdenv,
  buildGoModule,
  ...
}:
let
  version = "0.17.1";
  src = pkgs.fetchFromGitHub {
    owner = "Flomp";
    repo = "wanderer";
    tag = "v${version}";
    sha256 = "sha256-GDz+I1Cae/DqCC+WoEYX9Xre69bYc8Cp2mn8cc7TL+0=";
  };
in
buildGoModule {
  inherit version src;
  pname = "wanderer-db";

  vendorHash = "sha256-giXDMG3o6mtG5sbgRdXT+YAxBCLXy4daLENR2NbK5qM=";
  sourceRoot = "${src.name}/db";

  postInstall = ''
    mkdir -p $out/share
    cp -r migrations templates $out/share/
  '';

  meta.mainProgram = "pocketbase";
}
