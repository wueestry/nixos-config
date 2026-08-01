{ pkgs, inputs, ... }:

{
  programs.noctalia-shell = {
    enable = true;
    settings = { };
  };

  # noctalia-shell is the nix package name but upstream docs use "noctalia".
  # Symlink so the documented command works regardless of how other systems package it.
  home.packages = [
    (pkgs.runCommand "noctalia" { } ''
      mkdir -p $out/bin
      ln -s ${inputs.noctalia.packages.${pkgs.system}.default}/bin/noctalia-shell $out/bin/noctalia
    '')
  ];
}
