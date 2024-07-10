{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.desktop.hyprland;

  display_switcher = pkgs.writeShellScriptBin "display_switcher" ''
    #!/bin/sh

    if [[ $(hyprctl monitors) == *"eDP-1"* ]]; then
      hyprctl keyword monitor "eDP-1, disable"
    else
      hyprctl keyword monitor "eDP-1, prefered, auto, auto"
    fi
  '';

  playerctl = "${pkgs.playerctl}/bin/playerctl";
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  pactl = "${pkgs.pulseaudio}/bin/pactl";
in {
  options.${namespace}.desktop.hyprland = with types; {
    enable = mkBoolOpt false "Enable hyprland";
  };

  config = mkIf cfg.enable {
    xdg.desktopEntries."org.gnome.Settings" = {
      name = "Settings";
      comment = "Gnome Control Center";
      icon = "org.gnome.Settings";
      exec = "env XDG_CURRENT_DESKTOP=gnome ${pkgs.gnome.gnome-control-center}/bin/gnome-control-center";
      categories = ["X-Preferences"];
      terminal = false;
    };

    wayland.windowManager.hyprland = {
      enable = true;
      #enableNvidiaPatches = true;
      #extraConfig = import ./config.nix;
      systemd.enable = true;
      xwayland.enable = true;
      plugins = [];

      settings = {
        exec-once = [
          "ags &"
          "hyprctl setcursor Qogir 24"
        ];

        monitor = [
          ",preferred,auto,auto"
        ];

        general = {
          layout = "dwindle";
          gaps_in = 3;
          gaps_out = 5;
          border_size = 1;
        };

        misc = {
          animate_manual_resizes = true;
          disable_splash_rendering = true;
          mouse_move_focuses_monitor = true;
        };

        input = {
          kb_layout = "us";
          kb_variant = "altgr-intl";
          follow_mouse = 1;

          touchpad = {
            natural_scroll = true;
            disable_while_typing = true;
            tap-to-click = true;
          };

          sensitivity = 0;
        };

        device = [
          {
            name = "at-translated-set-2-keyboard";
            kb_layout = "ch";
            kb_variant = "";
          }
          {
            name = "msft0001:00-04f3:3202-mouse";
            sensitivity = 0;
            accel_profile = "adaptive";
          }
        ];

        binds = {
          allow_workspace_cycles = true;
        };

        gestures = {
          workspace_swipe = true;
          workspace_swipe_use_r = true;
        };

        windowrule = let
          f = regex: "float, ^(${regex})$";
        in [
          (f "org.gnome.Calculator")
          (f "org.gnome.Nautilus")
          (f "pavucontrol")
          (f "nm-connection-editor")
          (f "blueberry.py")
          (f "org.gnome.Settings")
          (f "org.gnome.design.Palette")
          (f "Color Picker")
          (f "xdg-desktop-portal")
          (f "xdg-desktop-portal-gnome")
          (f "de.haeckerfelix.Fragments")
          (f "com.github.Aylur.ags")
          "workspace 7, title:Spotify"
        ];

        bind = let
          binding = mod: cmd: key: arg: "${mod}, ${key}, ${cmd}, ${arg}";
          mvfocus = binding "SUPER" "movefocus";
          ws = binding "SUPER" "workspace";
          resizeactive = binding "SUPER CTRL" "resizeactive";
          mvactive = binding "SUPER ALT" "moveactive";
          mvtows = binding "SUPER SHIFT" "movetoworkspace";
          e = "exec, ags -b hypr";
          arr = [1 2 3 4 5 6 7 8 9];
        in
          [
            "CTRL SHIFT, R,  ${e} quit; ags -b hypr"
            "SUPER, D,       ${e} -t launcher"
            "SUPER, Tab,     ${e} -t overview"
            ",XF86PowerOff,  ${e} -r 'powermenu.shutdown()'"
            ",XF86Launch4,   ${e} -r 'recorder.start()'"
            ",Print,         ${e} -r 'recorder.screenshot()'"
            "SHIFT,Print,    ${e} -r 'recorder.screenshot(true)'"
            "SUPER, Return, exec, kitty"
            "SUPER, W, exec, brave"

            "ALT, Tab, focuscurrentorlast"
            "CTRL ALT, Delete, exit"
            "SUPER, Q, killactive"
            "SUPER, G, togglefloating"
            "SUPER, F, fullscreen"
            "SUPER, O, fakefullscreen"
            "SUPER, P, togglesplit"

            (mvfocus "k" "u")
            (mvfocus "j" "d")
            (mvfocus "l" "r")
            (mvfocus "h" "l")
            (ws "left" "e-1")
            (ws "right" "e+1")
            (mvtows "left" "e-1")
            (mvtows "right" "e+1")
            (resizeactive "k" "0 -20")
            (resizeactive "j" "0 20")
            (resizeactive "l" "20 0")
            (resizeactive "h" "-20 0")
            (mvactive "k" "0 -20")
            (mvactive "j" "0 20")
            (mvactive "l" "20 0")
            (mvactive "h" "-20 0")
          ]
          ++ (map (i: ws (toString i) (toString i)) arr)
          ++ (map (i: mvtows (toString i) (toString i)) arr);

        bindle = [
          ",XF86MonBrightnessUp,   exec, ${brightnessctl} set +5%"
          ",XF86MonBrightnessDown, exec, ${brightnessctl} set  5%-"
          ",XF86KbdBrightnessUp,   exec, ${brightnessctl} -d asus::kbd_backlight set +1"
          ",XF86KbdBrightnessDown, exec, ${brightnessctl} -d asus::kbd_backlight set  1-"
          ",XF86AudioRaiseVolume,  exec, ${pactl} set-sink-volume @DEFAULT_SINK@ +5%"
          ",XF86AudioLowerVolume,  exec, ${pactl} set-sink-volume @DEFAULT_SINK@ -5%"
        ];

        bindl = [
          ",XF86AudioPlay,    exec, ${playerctl} play-pause"
          ",XF86AudioStop,    exec, ${playerctl} pause"
          ",XF86AudioPause,   exec, ${playerctl} pause"
          ",XF86AudioPrev,    exec, ${playerctl} previous"
          ",XF86AudioNext,    exec, ${playerctl} next"
          ",XF86AudioMicMute, exec, ${pactl} set-source-mute @DEFAULT_SOURCE@ toggle"
        ];

        bindm = [
          "SUPER, mouse:273, resizewindow"
          "SUPER, mouse:272, movewindow"
        ];

        decoration = {
          drop_shadow = "yes";
          shadow_range = 8;
          shadow_render_power = 2;
          "col.shadow" = "rgba(00000044)";

          dim_inactive = false;

          blur = {
            enabled = true;
            size = 8;
            passes = 3;
            new_optimizations = "on";
            noise = 0.01;
            contrast = 0.9;
            brightness = 0.8;
            popups = true;
          };
        };

        animations = {
          enabled = "yes";
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 5, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        plugin = {
          overview = {
            centerAligned = true;
            hideTopLayers = true;
            hideOverlayLayers = true;
            showNewWorkspace = true;
            exitOnClick = true;
            exitOnSwitch = true;
            drawActiveWorkspace = true;
            reverseSwipe = true;
          };
          hyprbars = {
            bar_color = "rgb(2a2a2a)";
            bar_height = 28;
            col_text = "rgba(ffffffdd)";
            bar_text_size = 11;
            bar_text_font = "Ubuntu Nerd Font";

            buttons = {
              button_size = 0;
              "col.maximize" = "rgba(ffffff11)";
              "col.close" = "rgba(ff111133)";
            };
          };
        };
      };
    };
  };
}
