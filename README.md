# nixos-config

Flake-based, modular NixOS configuration using home-manager.

## Layout

```
.
├── flake.nix                  # inputs + wires hosts together
├── lib/default.nix            # mkHost helper used by flake.nix
├── hosts/<name>/               # one directory per machine
│   ├── default.nix            # host-specific config
│   └── hardware-configuration.nix
├── modules/
│   ├── nixos/                 # system-level modules, imported by every host
│   └── home-manager/          # user-level modules, imported by every home
├── home/<user>/default.nix    # per-user home-manager entrypoint
├── vms/<name>/default.nix     # declarative MicroVM guest configs
├── overlays/default.nix       # package overlays (currently unused)
├── pkgs/default.nix           # custom package derivations (currently unused)
└── .sops.yaml                 # sops-nix key/rule config for encrypted secrets
```

Adding a host means creating `hosts/<name>/` and adding it to
`nixosConfigurations` in `flake.nix`. Adding a user means creating
`home/<user>/default.nix` and listing them in that host's `users = [ ... ]`.
Every host gets all of `modules/nixos/`; every user gets all of
`modules/home-manager/`. There's no host- or user-specific opt-out
mechanism yet — if that's ever needed, split `modules/nixos/default.nix`'s
import list into groups and have hosts import only what they want.

Modules that only apply to one machine (e.g. a `nixos-hardware` profile)
don't go in `modules/nixos/` — import them straight into that host's
`default.nix` instead, the way athena pulls in
`inputs.nixos-hardware.nixosModules.lenovo-yoga-7-14ARH7-nvidia`.

## `flake.nix` / `lib/default.nix`

`flake.nix` only declares inputs and calls `lib.mkHost` per host.
`mkHost` (in `lib/default.nix`) builds the actual `nixosSystem`:
imports the host directory, `modules/nixos`, and the flake inputs that
ship their own NixOS module (flatpak, sops-nix, niri). Home-manager is
wired in as a NixOS module, so `nixos-rebuild switch` rebuilds the system
and every user's home in one go — there's no separate `home-manager switch`
step.

`nixpkgs` tracks the `nixos-26.05` stable channel; `nixpkgs-unstable` is
a second input available for pulling individual packages ahead of stable
(not currently wired into any module — add an overlay like the removed
`unstable.nix` example if/when you need it). `dms` and `dgop` deliberately
do *not* follow the pinned `nixpkgs`, since they need a newer
`quickshell`/toolchain than stable ships.

## `modules/nixos/`

| File | What it does |
|---|---|
| `boot.nix` | systemd-boot bootloader |
| `plymouth.nix` | graphical boot splash + themed LUKS decryption prompt |
| `networking.nix` | NetworkManager, redistributable wifi/bluetooth firmware |
| `audio.nix` | pipewire (+ alsa/pulse compat) |
| `bluetooth.nix` | Bluetooth stack + blueman applet |
| `hardening.nix` | AppArmor, firewall, sudo restricted to `wheel`, kernel/network sysctls |
| `flatpak.nix` | Flatpak + Flathub, declarative app list via `nix-flatpak` |
| `firejail.nix` | Fallback sandbox for natively-packaged apps without a Flatpak |
| `secrets.nix` | sops-nix: decrypts using the host's own SSH key |
| `niri.nix` | Niri Wayland compositor (via niri-flake) |
| `regreet.nix` | ReGreet login screen (auto-configures greetd) |

`security.selinux` was considered instead of AppArmor but isn't usable on
NixOS yet (unmerged, see nixpkgs PR #396177) — AppArmor is the MAC layer
that actually works today.

## `modules/home-manager/`

| File | What it does |
|---|---|
| `shell.nix` | zsh with autosuggestions/syntax highlighting |
| `git.nix` | git identity |
| `neovim.nix` | neovim as default editor |
| `niri.nix` | per-user niri settings (currently Swiss German keyboard layout) |
| `dank-material-shell.nix` | enables DankMaterialShell (the desktop shell running on niri) |
| `sops-tools.nix` | `sops`/`age`/`ssh-to-age` CLIs for editing secrets |

## MicroVMs (`vms/`)

[microvm.nix](https://github.com/microvm-nix/microvm.nix) gives declarative,
reproducible VMs for isolating individual apps (browser, dev sandbox, etc.)
the way the earlier security-hardening pass discussed — a lighter-weight
alternative to Flatpak/firejail for things that need real VM-level
separation. Each guest is its own `nixosConfigurations` entry, built via
`lib.mkMicrovm` (parallel to `lib.mkHost`) and defined in `vms/<name>/`.

`vms/example/` is a template: 2 vCPU, 1G RAM, headless (no GUI forwarding —
that's separate work if you want a VM's window to appear on the host
desktop), qemu hypervisor, read-only virtiofs share of the host's
`/nix/store`, and its own tap network interface. To add another VM, copy
that directory, give it a new hostname, and add both a `nixosConfigurations`
entry in `flake.nix` and a `microvm.vms.<name>.flake = inputs.self;` line
on whichever host should run it (see `hosts/athena/microvm.nix`).

athena hosts VMs via `microvm.nixosModules.host` and gives their tap
interfaces a private `br-vms` bridge with NAT (`IPMasquerade`), kept
separate from the physical wifi link that NetworkManager manages. This
host-level wiring currently lives in `hosts/athena/microvm.nix` since
athena is the only host using it — move it to `modules/nixos/` if a second
host needs the same setup.

Run a VM directly for testing without touching the host:
```sh
nix run .#example-vm
```

## Secrets (sops-nix)

Secrets are encrypted with [sops](https://github.com/getsops/sops) and
committed to the repo as ciphertext; only machines/people with a matching
`age` key can decrypt. Rules and public keys live in `.sops.yaml` — both
keys in there are placeholders and need to be replaced before encrypting
anything real:

```sh
# athena's key, once it's installed (derived from its SSH host key):
ssh-to-age -i /etc/ssh/ssh_host_ed25519_key.pub

# your own key, so you can edit secrets from your laptop:
ssh-to-age -i ~/.ssh/id_ed25519.pub
```

Then create the first secrets file and uncomment `sops.defaultSopsFile` /
`sops.secrets` in `modules/nixos/secrets.nix`:

```sh
mkdir -p secrets/athena
sops secrets/athena/secrets.yaml
```

## Rebuilding

```sh
sudo nixos-rebuild switch --flake .#athena
```

Before that works on real hardware, replace
`hosts/athena/hardware-configuration.nix` with the real output of
`nixos-generate-config` run on athena itself — the checked-in version is a
placeholder.
