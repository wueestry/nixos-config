# niri-flake's NixOS module also wires up the home-manager niri module
# automatically (since home-manager is integrated as a NixOS module here),
# and sets up the desktop portals/polkit niri needs to function.
{ inputs, ... }:

{
  programs.niri.enable = true;
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
}
