<h1 align="center"> <img src="./.github/assets/flake.webp" width="250px"/></h1>
<h2 align="center">My NixOS flake made with <a href="https://github.com/snowfallorg/lib">snowfall</a>.</h2>

## Systems

- *Athena*: Lenovo Yoga Pro 7X Slim Nvidia
    - Used for development

- *Ares*: Workstation (AMD Ryzen 7 5800X, NVIDIA RTX 3070)
    - Dual boot


### Generating user-dirs

After a fresh install, the user home directory is completly empty. In order to generate the Documents, Downloads, eg. subfolders run
```
nix-shell -p xdg-user-dirs
xdg-user-dirs-update
```
