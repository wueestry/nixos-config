{
  options,
  config,
  lib,
  pkgs,
  namespace,
  inputs,
  osConfig ? { },
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.niri;

  gaps = 8;

  xkbLayout = osConfig.services.xserver.xkb.layout or "us";
  xkbVariant = osConfig.services.xserver.xkb.variant or "";

  workspace-binds = builtins.listToAttrs (
    builtins.concatMap (
      i:
      let
        key = toString (if i == 9 then 0 else i + 1);
      in
      [
        {
          name = "Mod+${key}";
          value.action.focus-workspace = i + 1;
        }
        {
          name = "Mod+Shift+${key}";
          value.action.move-window-to-workspace = i + 1;
        }
      ]
    ) (builtins.genList (i: i) 10)
  );
in
{
  imports = [
    inputs.niri-flake.homeModules.niri
    inputs.niri-flake.homeModules.stylix
  ];

  options.${namespace}.desktop.niri = with types; {
    enable = mkBoolOpt false "Enable niri";
    browserCommand = mkOpt (nullOr (listOf str)) null "Argv used to launch the default browser via Mod+B (host-specific: browser choice/packaging differs per host).";
  };

  config = mkIf cfg.enable {
    olympus.desktop.utils = {
      noctalia = enabled;
      swayidle = enabled;
    };

    home.packages = with pkgs; [
      # minimal terminal so the session is usable before Phase 3 installs a
      # properly themed one via olympus.programs.gui.kitty
      kitty

      xwayland-satellite
      wl-clipboard
      wl-clip-persist
      grim
      slurp
      brightnessctl
      libnotify
    ];

    # niri itself is installed system-wide by the NixOS module
    # (olympus.desktop.niri / programs.niri.enable there); this just needs
    # settings, but the home module's `enable` gates whether it writes
    # ~/.config/niri/config.kdl at all, so set both.
    programs.niri.enable = true;
    programs.niri.settings = {
      input = {
        keyboard.xkb = {
          layout = xkbLayout;
          variant = xkbVariant;
        };
        touchpad = {
          tap = true;
          natural-scroll = true;
          click-method = "clickfinger";
        };
        mouse = {
          accel-profile = "adaptive";
        };
      };

      # Border on/off + colors are left to niri-flake's stylix target
      # (inputs.niri-flake.homeModules.stylix, imported above), which turns
      # on layout.border automatically and themes it from the same base16
      # scheme as everything else.
      layout = {
        gaps = gaps;
        center-focused-column = "never";
        default-column-width.proportion = 0.5;
      };

      # TODO(verify on hardware): niri names outputs by connector (e.g.
      # "eDP-1"), not a wildcard like Hyprland's ",prefered,auto,auto".
      # Run `niri msg outputs` after first login and fill in real names if
      # per-output scale/position/vrr tuning is needed. Left empty here so
      # niri just uses its (generally sane) auto-detected defaults.
      outputs = { };

      cursor = {
        hide-when-typing = true;
      };

      # noctalia's recommended niri integration
      # (https://docs.noctalia.dev/v5/compositor-settings/niri/)
      spawn-at-startup = [
        { sh = "noctalia"; }
      ];

      window-rules = [
        {
          geometry-corner-radius = {
            top-left = 10.0;
            top-right = 10.0;
            bottom-left = 10.0;
            bottom-right = 10.0;
          };
          clip-to-geometry = true;
        }
        {
          matches = [ { app-id = "^dev\\.noctalia\\.Noctalia$"; } ];
          open-floating = true;
          default-column-width.fixed = 1080;
          default-window-height.fixed = 920;
        }
      ];

      # noctalia's recommended layer-rule so its own bar/panel/dock surfaces
      # aren't affected by any backdrop blur/x-ray effect.
      layer-rules = [
        {
          matches = [ { namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel)"; } ];
          background-effect.xray = false;
        }
      ];

      binds = mkMerge [
        workspace-binds
        (mkIf (cfg.browserCommand != null) {
          "Mod+B".action.spawn = cfg.browserCommand;
        })
        {
          "Mod+Return".action.spawn = "kitty";
          "Mod+E".action.spawn = "nautilus";

          "Mod+Space".action.spawn = [
            "noctalia"
            "msg"
            "panel-toggle"
            "launcher"
          ];
          "Mod+S".action.spawn = [
            "noctalia"
            "msg"
            "panel-toggle"
            "control-center"
          ];
          "Mod+Comma".action.spawn = [
            "noctalia"
            "msg"
            "settings-toggle"
          ];
          "Mod+L".action.spawn = [
            "noctalia"
            "msg"
            "session"
            "lock"
          ];

          "Mod+Q".action.close-window = { };
          "Mod+F".action.maximize-column = { };
          "Mod+Shift+F".action.fullscreen-window = { };
          "Mod+T".action.toggle-window-floating = { };

          "Mod+Left".action.focus-column-left = { };
          "Mod+Right".action.focus-column-right = { };
          "Mod+Down".action.focus-window-down = { };
          "Mod+Up".action.focus-window-up = { };

          "Mod+Shift+Left".action.move-column-left = { };
          "Mod+Shift+Right".action.move-column-right = { };
          "Mod+Shift+Down".action.move-window-down = { };
          "Mod+Shift+Up".action.move-window-up = { };

          "Mod+BracketLeft".action.consume-window-into-column = { };
          "Mod+BracketRight".action.expel-window-from-column = { };

          "Print".action.screenshot-screen = { };
          "Mod+Print".action.screenshot-window = { };
          "Shift+Print".action.screenshot = { };

          "XF86MonBrightnessUp".action.spawn = [
            "brightnessctl"
            "set"
            "5%+"
          ];
          "XF86MonBrightnessDown".action.spawn = [
            "brightnessctl"
            "set"
            "5%-"
          ];
        }
      ];
    };
  };
}
