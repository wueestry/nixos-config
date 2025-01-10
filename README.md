<h1 align="center"> <img src="./.github/assets/flake.webp" width="250px"/></h1>
<h2 align="center">My NixOS flake made with <a href="https://github.com/snowfallorg/lib">snowfall</a>.</h2>

<img src="https://github.com/wueestry/nixos-config/blob/master/.github/assets/desktop.png" width="1000" />

## Systems

- *Apollo*: Homeserver
    - Running the following services on a tailscale network
        - Audiobookshelf
        - Calibre / Calibre Web
        - Firefly III
        - Immich
        - Jellyfin
        - Nextcloud
        - Mealie
        - Wanderer

- *Ares*: Workstation (AMD Ryzen 7 5800X, NVIDIA RTX 3070)
    - Dual boot with Windows

- *Athena*: Lenovo Yoga Pro 7X Slim Nvidia
    - Used for development

## Installation
1. Enable flakes in nixos. By adding the following lines to `/etc/nixos/config.nix`.
```
nix = {
  package = pkgs.nixFlakes;
  extraOptions = "experimental-features = nix-command flakes";
};
```
2. Add **git** to your nixos configuration.
```
systemPackages = with pkgs; [
  git
];
```
3. Rebuild nixos by running `sudo nixos-rebuild switch`.
4. Clone repo `git clone git@github.com:wueestry/nixos-config.git`. Enter into repo by running `cd nixos-config`.
5. Copy own hardware file into repo `sudo cp /etc/nixos/hardware-configuration.nix ~/nixos-config/systems/{computer architecture}/{desired config}/hardware.nix`.
6. Build flakes by running `sudo nixos-rebuild boot --flake .#{desired config}`.
7. *Optional*: Update nixpkgs by running `nix flake update` and then rebuild system as described in step 6.

### Add your own config
1. Add your own nixos config into the directory `systems/{computer architecture}/{config name}/default.nix`.
2. Add your hardware config to `systems/{computer architecture}/{config name}/hardware.nix`.
3. Add your home manager config into the directory `homes/{computer architecture}/{user}@{config name}`.
4. *Optional*: Add specific nixos-hardware package to the `flake.nix` file. Similar to:
```
systems.hosts.athena.modules = with inputs; [
  nixos-hardware.nixosModules.lenovo-yoga-7-14ARH7-nvidia
];
```

### Generating user-dirs

After a fresh install, the user home directory is completly empty. In order to generate the Documents, Downloads, eg. subfolders run
```
nix-shell -p xdg-user-dirs
xdg-user-dirs-update
```

## Inspiration
Thanks to the work of the following projects which inspired this configuration:
- [anotherhadi/nixy](https://github.com/anotherhadi/nixy)
- [jakehamilton/config](https://github.com/jakehamilton/config)
