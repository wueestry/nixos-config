{ pkgs, ... }:

{
  # CLI tools for editing secrets/*.yaml and deriving age keys from SSH keys.
  home.packages = [
    pkgs.sops
    pkgs.age
    pkgs.ssh-to-age
  ];
}
