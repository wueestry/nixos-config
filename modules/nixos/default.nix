{
  imports = [
    # system
    ./nix.nix
    ./boot.nix
    ./plymouth.nix
    ./networking.nix
    ./audio.nix
    ./power.nix
    ./hardening.nix
    ./dconf.nix
    ./flatpak.nix
    ./firejail.nix
    ./secrets.nix
    ./bluetooth.nix
    ./virtualisation.nix
    # desktop
    ./niri.nix
    ./greeter.nix
    ./dank-material-shell.nix
    # user tools
    ./shell.nix
    ./cli-tools.nix
    ./git.nix
    ./kitty.nix
    ./matugen.nix
    ./nautilus.nix
    ./neovim.nix
    ./qt6ct.nix
    ./sops-tools.nix
    ./starship.nix
    ./tailscale.nix
    ./tmux.nix
  ];
}
