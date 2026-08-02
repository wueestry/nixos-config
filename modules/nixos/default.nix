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
    ./flatpak.nix
    ./firejail.nix
    ./secrets.nix
    ./bluetooth.nix
    # desktop
    ./niri.nix
    ./greeter.nix
    ./dank-material-shell.nix
    # user tools
    ./shell.nix
    ./cli-tools.nix
    ./git.nix
    ./kitty.nix
    ./neovim.nix
    ./sops-tools.nix
  ];
}
