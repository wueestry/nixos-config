{
  lib,
  inputs,
  namespace,
  pkgs,
  stdenv,
  writeShellApplication,
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
  wanderer-web-dist = pkgs.buildNpmPackage {
    inherit version src;
    pname = "wanderer-web-dist";

    npmDepsHash = "sha256-fck1BYU59qW3RamUXk+gu9kA6EoUPU/8SERUr4o3x/E=";
    npmFlags = [ "--legacy-peer-deps" ];
    makeCacheWritable = true;
    sourceRoot = "${src.name}/web";

    installPhase = ''
      runHook preInstall
      mkdir -p $out
      cp -r build/ $out/dist
      cp -r node_modules $out/node_modules
      runHook postInstall
    '';
  };
in
writeShellApplication {
  name = "wanderer-web";
  text = "${pkgs.nodejs_22}/bin/node ${wanderer-web-dist}/dist/";
}
