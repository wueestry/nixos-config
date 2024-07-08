{
  options,
  config,
  lib,
  inputs,
  namespace,
  pkgs,
  ...
}: with lib;
with lib.${namespace}; let
  name = config.${namespace}.config.user.name;

  ags = inputs.ags.packages.default.override {
    extraPackages = [pkgs.accountsservice];
  };

  dependencies = with pkgs; [
    which
    dart-sass
    fd
    fzf
    brightnessctl
    swww
    matugen
    slurp
    wf-recorder
    wl-clipboard
    wayshot
    swappy
    hyprpicker
    pavucontrol
    networkmanager
    gtk3
  ];

  addBins = list: builtins.concatStringsSep ":" (builtins.map (p: "${p}/bin") list);

  greeter = writeShellScript "greeter" ''
    export PATH=$PATH:${addBins dependencies}
    ${cage}/bin/cage -ds -m last ${ags}/bin/ags -- -c ${config}/greeter.js
  '';

  desktop = writeShellScript name ''
    export PATH=$PATH:${addBins dependencies}
    ${ags}/bin/ags -b ${name} -c ${config}/config.js $@
  '';

  config = pkgs.stdenv.mkDerivation {
    inherit name;
    src = ./.;

    buildPhase = ''
      ${esbuild}/bin/esbuild \
        --bundle ./main.ts \
        --outfile=main.js \
        --format=esm \
        --external:resource://\* \
        --external:gi://\* \

      ${esbuild}/bin/esbuild \
        --bundle ./greeter/greeter.ts \
        --outfile=greeter.js \
        --format=esm \
        --external:resource://\* \
        --external:gi://\* \
    '';

    installPhase = ''
      mkdir -p $out
      cp -r assets $out
      cp -r style $out
      cp -r greeter $out
      cp -r widget $out
      cp -f main.js $out/config.js
      cp -f greeter.js $out/greeter.js
    '';
  };
in
{}
