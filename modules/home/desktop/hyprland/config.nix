''
      # █▀▀ ▀▄▀ █▀▀ █▀▀
      # ██▄ █░█ ██▄ █▄▄

      # Fix slow startup
      #exec-once systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      #exec-once dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

      exec-once = blueman-applet
      exec-once = nm-applet --indicator # Systray app for Network/Wifi
      #exec-once = waybar # launch the system panel
      #exec-once = dunst # start notification demon
      #exec-once = nextcloud --background


      # █▀▀ █▀█ █░░ █▀█ █░█ █▀█
      # █▄▄ █▄█ █▄▄ █▄█ █▄█ █▀▄

      $rosewaterAlpha = f5e0dc
      $flamingoAlpha  = f2cdcd
      $pinkAlpha      = f5c2e7
      $mauveAlpha     = cba6f7
      $redAlpha       = f38ba8
      $maroonAlpha    = eba0ac
      $peachAlpha     = fab387
      $yellowAlpha    = f9e2af
      $greenAlpha     = a6e3a1
      $tealAlpha      = 94e2d5
      $skyAlpha       = 89dceb
      $sapphireAlpha  = 74c7ec
      $blueAlpha      = 89b4faF
      $lavenderAlpha  = b4befe

      $textAlpha      = cdd6f4
      $subtext1Alpha  = bac2de
      $subtext0Alpha  = a6adc8

      $overlay2Alpha  = 9399b2
      $overlay1Alpha  = 7f849c
      $overlay0Alpha  = 6c7086

      $surface2Alpha  = 585b70
      $surface1Alpha  = 45475a
      $surface0Alpha  = 313244

      $baseAlpha      = 1e1e2e
      $mantleAlpha    = 181825
      $crustAlpha     = 11111b

      $rosewater = 0xfff5e0dc
      $flamingo  = 0xfff2cdcd
      $pink      = 0xfff5c2e7
      $mauve     = 0xffcba6f7
      $red       = 0xfff38ba8
      $maroon    = 0xffeba0ac
      $peach     = 0xfffab387
      $yellow    = 0xfff9e2af
      $green     = 0xffa6e3a1
      $teal      = 0xff94e2d5
      $sky       = 0xff89dceb
      $sapphire  = 0xff74c7ec
      $blue      = 0xff89b4fa
      $lavender  = 0xffb4befe

      $text      = 0xffcdd6f4
      $subtext1  = 0xffbac2de
      $subtext0  = 0xffa6adc8

      $overlay2  = 0xff9399b2
      $overlay1  = 0xff7f849c
      $overlay0  = 0xff6c7086

      $surface2  = 0xff585b70
      $surface1  = 0xff45475a
      $surface0  = 0xff313244

      $base      = 0xff1e1e2e
      $mantle    = 0xff181825
      $crust     = 0xff11111b



      # █▀▄▀█ █▀█ █▄░█ █ ▀█▀ █▀█ █▀█
      # █░▀░█ █▄█ █░▀█ █ ░█░ █▄█ █▀▄

      monitor=,preferred,auto,auto


      # █ █▄░█ █▀█ █░█ ▀█▀
      # █ █░▀█ █▀▀ █▄█ ░█░

      input {
          kb_layout = us
          kb_variant = altgr-intl
          follow_mouse = 1
          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
          force_no_accel = 0
          touchpad {
              natural_scroll = true
          }
      }

      device {
      name = logitech-k520
      kb_layout = ch
      kb_variant =
  }

  device {
      name = at-translated-set-2-keyboard
      kb_layout = ch
      kb_variant =
  }

  device {
      name = msft0001:00-04f3:3202-mouse
      sensitivity = 0
      accel_profile = adaptive
  }


      # █▀▀ █▀▀ █▄░█ █▀▀ █▀█ ▄▀█ █░░
      # █▄█ ██▄ █░▀█ ██▄ █▀▄ █▀█ █▄▄

      general {
          gaps_in = 3
          gaps_out = 8
          border_size = 2
          col.active_border = $red $pink 45deg
          col.inactive_border = $teal $sky 45deg
          layout = dwindle
          no_cursor_warps = true
      }

      # █▀▄▀█ █ █▀ █▀▀
      # █░▀░█ █ ▄█ █▄▄

      misc {
      disable_hyprland_logo = true
      disable_splash_rendering = true
      mouse_move_enables_dpms = true
      vfr = true
      vrr = 0
      animate_manual_resizes = true
      mouse_move_focuses_monitor = true
      enable_swallow = true
      swallow_regex = ^(alacritty)$
      }


      # █▀▄ █▀▀ █▀▀ █▀█ █▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█
      # █▄▀ ██▄ █▄▄ █▄█ █▀▄ █▀█ ░█░ █ █▄█ █░▀█

      decoration {

          # █▀█ █▀█ █░█ █▄░█ █▀▄   █▀▀ █▀█ █▀█ █▄░█ █▀▀ █▀█
          # █▀▄ █▄█ █▄█ █░▀█ █▄▀   █▄▄ █▄█ █▀▄ █░▀█ ██▄ █▀▄

          rounding = 10

          # █▀█ █▀█ ▄▀█ █▀▀ █ ▀█▀ █▄█
          # █▄█ █▀▀ █▀█ █▄▄ █ ░█░ ░█░

          active_opacity = 0.8
          inactive_opacity = 0.8

          # █▄▄ █░░ █░█ █▀█
          # █▄█ █▄▄ █▄█ █▀▄

          # Required config from v0.28 onward
          blur {
              enabled = true
              size = 5
      passes = 5
      new_optimizations = true
          }


          # █▀ █░█ ▄▀█ █▀▄ █▀█ █░█░█
          # ▄█ █▀█ █▀█ █▄▀ █▄█ ▀▄▀▄▀

          drop_shadow = false
          shadow_range = 0
          shadow_render_power = 0
          col.shadow = $crust
      }


      # ▄▀█ █▄░█ █ █▀▄▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█
      # █▀█ █░▀█ █ █░▀░█ █▀█ ░█░ █ █▄█ █░▀█

      animations {
          enabled = yes

          # █▄▄ █▀▀ ▀█ █ █▀▀ █▀█   █▀▀ █░█ █▀█ █░█ █▀▀
          # █▄█ ██▄ █▄ █ ██▄ █▀▄   █▄▄ █▄█ █▀▄ ▀▄▀ ██▄

          bezier = wind, 0.05, 0.9, 0.1, 1.05
          bezier = winIn, 0.1, 1.1, 0.1, 1.1
          bezier = winOut, 0.3, -0.3, 0, 1
          bezier = liner, 1, 1, 1, 1

          # ▄▀█ █▄░█ █ █▀▄▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█
          # █▀█ █░▀█ █ █░▀░█ █▀█ ░█░ █ █▄█ █░▀█

          animation = windows, 1, 6, wind, slide
          animation = windowsIn, 1, 6, winIn, slide
          animation = windowsOut, 1, 5, winOut, slide
          animation = windowsMove, 1, 5, wind, slide
          animation = border, 1, 1, liner
          animation = borderangle, 1, 30, liner, loop
          animation = fade, 1, 10, default
          animation = workspaces, 1, 5, wind
      }


      # █░░ ▄▀█ █▄█ █▀█ █░█ ▀█▀ █▀
      # █▄▄ █▀█ ░█░ █▄█ █▄█ ░█░ ▄█

      dwindle {
      no_gaps_when_only = false
      pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
      preserve_split = yes # you probably want this
      }

      master {
      # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
      new_is_master = true
      }


      # █▀▀ █▀▀ █▀ ▀█▀ █░█ █▀█ █▀▀ █▀
      # █▄█ ██▄ ▄█ ░█░ █▄█ █▀▄ ██▄ ▄█

      gestures {
      # See https://wiki.hyprland.org/Configuring/Variables/ for more
      workspace_swipe = true
      }

      # █▄▀ █▀▀ █▄█ █▄▄ █ █▄░█ █▀▄
      # █░█ ██▄ ░█░ █▄█ █ █░▀█ █▄▀

      $notifycmd = notify-send -h string:x-canonical-private-synchronous:hypr-cfg -u low

      $mainMod = SUPER

      # IDK
      $term = kitty
      $files = dolphin
      $browser = brave


      # █▀ █▀▀ █▀█ █▀▀ █▀▀ █▄░█ █▀ █░█ █▀█ ▀█▀
      # ▄█ █▄▄ █▀▄ ██▄ ██▄ █░▀█ ▄█ █▀█ █▄█ ░█░

      bind = $mainMod, P, exec, grim -g "$(slurp)" - | swappy -f - # screenshot snip
      bind = $mainMod ALT, P, exec, grim ~/Picture/grim/$(date +'%y%m%d_%Hh%Mm%Ss_screenshot.png') # print current screen
      bind = $mainMod, D, exec, display_switcher

      # █▀▄▀█ █ █▀ █▀▀
      # █░▀░█ █ ▄█ █▄▄

      bind = $mainMod SHIFT, B, exec, killall -SIGUSR2 waybar # Reload waybar
      bind = $mainMod, L, exec, power-menu # lock screen
      bind = $mainMod, Return, exec, $term
      bind = $mainMod, E, exec, $files
      bind = $mainMod, V, exec, code # open vs code
      bind = $mainMod, B, exec, $browser
      bind = $mainMod, O, exec, obsidian
      bind = $mainMod SHIFT, X, exec, $colorpicker
      bind = $mainMod, space, exec, launcher
      bind = $mainMod, N, exec, kitty -- distrobox enter ros-noetic
      bind = $mainMod, H, exec, kitty -- distrobox enter ros-humble

      bind = ,XF86MonBrightnessUp, exec, brightness set +5%
      bind = ,XF86MonBrightnessDown, exec, brightness set 5%-
      bind = ,XF86AudioRaiseVolume, exec, volume -i 5
      bind = ,XF86AudioLowerVolume, exec, volume -d 5
      bind = ,XF86AudioMute, exec, volume -t
      bind = ,XF86AudioMicMute, exec, microphone -t

      # █░█░█ █ █▄░█ █▀▄ █▀█ █░█░█   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀
      # ▀▄▀▄▀ █ █░▀█ █▄▀ █▄█ ▀▄▀▄▀   █░▀░█ █▀█ █░▀█ █▀█ █▄█ █░▀░█ ██▄ █░▀█ ░█░

      bind = $mainMod, Q, killactive,
      bind = $mainMod SHIFT, Q, exit,
      bind = $mainMod, F, fullscreen,
      bind = $mainMod, W, togglefloating,
      bind = $mainMod ALT, P, pseudo, # dwindle
      bind = $mainMod, S, togglesplit, # dwindle

      # Change Workspace Mode
      bind = $mainMod SHIFT, W, workspaceopt, allfloat
      bind = $mainMod SHIFT, W, exec, $notifycmd 'Toggled All Float Mode'
      bind = $mainMod ALT SHIFT, P, workspaceopt, allpseudo
      bind = $mainMod ALT SHIFT, P, exec, $notifycmd 'Toggled All Pseudo Mode'

      bind = $mainMod, Tab, cyclenext,
      bind = $mainMod, Tab, bringactivetotop,


      # █▀▀ █▀█ █▀▀ █░█ █▀
      # █▀░ █▄█ █▄▄ █▄█ ▄█

      bind = $mainMod, h, movefocus, l
      bind = $mainMod, l, movefocus, r
      bind = $mainMod, k, movefocus, u
      bind = $mainMod, j, movefocus, d


      # █▀▄▀█ █▀█ █░█ █▀▀
      # █░▀░█ █▄█ ▀▄▀ ██▄

      bind = $mainMod SHIFT, left, movewindow, l
      bind = $mainMod SHIFT, right, movewindow, r
      bind = $mainMod SHIFT, up, movewindow, u
      bind = $mainMod SHIFT, down, movewindow, d


      # █▀█ █▀▀ █▀ █ ▀█ █▀▀
      # █▀▄ ██▄ ▄█ █ █▄ ██▄

      bind = $mainMod CTRL, left, resizeactive, -20 0
      bind = $mainMod CTRL, right, resizeactive, 20 0
      bind = $mainMod CTRL, up, resizeactive, 0 -20
      bind = $mainMod CTRL, down, resizeactive, 0 20


      # █▀ █░█░█ █ ▀█▀ █▀▀ █░█
      # ▄█ ▀▄▀▄▀ █ ░█░ █▄▄ █▀█

      bind = SUPER, 1, workspace, 1
      bind = SUPER, 2, workspace, 2
      bind = SUPER, 3, workspace, 3
      bind = SUPER, 4, workspace, 4
      bind = SUPER, 5, workspace, 5
      bind = SUPER, 6, workspace, 6
      bind = SUPER, 7, workspace, 7
      bind = SUPER, 8, workspace, 8
      bind = SUPER, 9, workspace, 9
      bind = SUPER, 0, workspace, 10
      bind = CONTROL ALT, left, workspace, e-1
      bind = CONTROL ALT, right, workspace, e+1


      # █▀▄▀█ █▀█ █░█ █▀▀
      # █░▀░█ █▄█ ▀▄▀ ██▄

      bind = SUPER SHIFT, 1, movetoworkspace, 1
      bind = SUPER SHIFT, 2, movetoworkspace, 2
      bind = SUPER SHIFT, 3, movetoworkspace, 3
      bind = SUPER SHIFT, 4, movetoworkspace, 4
      bind = SUPER SHIFT, 5, movetoworkspace, 5
      bind = SUPER SHIFT, 6, movetoworkspace, 6
      bind = SUPER SHIFT, 7, movetoworkspace, 7
      bind = SUPER SHIFT, 8, movetoworkspace, 8
      bind = SUPER SHIFT, 9, movetoworkspace, 9
      bind = SUPER SHIFT, 0, movetoworkspace, 10


      # █▀▄▀█ █▀█ █░█ █▀ █▀▀   █▄▄ █ █▄░█ █▀▄ █ █▄░█ █▀▀
      # █░▀░█ █▄█ █▄█ ▄█ ██▄   █▄█ █ █░▀█ █▄▀ █ █░▀█ █▄█

      bindm = SUPER, mouse:272, movewindow
      bindm = SUPER, mouse:273, resizewindow
      bind = SUPER, mouse_down, workspace, e+1
      bind = SUPER, mouse_up, workspace, e-1


      # █░█░█ █ █▄░█ █▀▄ █▀█ █░█░█   █▀█ █░█ █░░ █▀▀ █▀
      # ▀▄▀▄▀ █ █░▀█ █▄▀ █▄█ ▀▄▀▄▀   █▀▄ █▄█ █▄▄ ██▄ ▄█

      windowrulev2 = opacity 0.80 0.80,class:^(firefox)$
      windowrulev2 = opacity 0.80 0.80,class:^(steam)$
      windowrulev2 = opacity 0.80 0.80,class:^(steamwebhelper)$
      windowrulev2 = opacity 0.80 0.80,class:^(spotify)$
      windowrulev2 = opacity 0.80 0.80,class:^(code)$
      windowrulev2 = opacity 0.80 0.80,class:^(alacritty)$
      windowrulev2 = opacity 0.80 0.80,class:^(dolphin)$
      windowrulev2 = opacity 0.80 0.80,class:^(nwg-look)$
      windowrulev2 = opacity 0.80 0.80,class:^(qt5ct)$

      windowrulev2 = opacity 0.80 0.80,class:^(obsidian)$
      windowrulev2 = opacity 0.80 0.80,class:^(brave)$

      windowrulev2 = opacity 0.80 0.70,class:^(pavucontrol)$
      windowrulev2 = opacity 0.80 0.70,class:^(blueman-manager)$
      windowrulev2 = opacity 0.80 0.70,class:^(nm-applet)$
      windowrulev2 = opacity 0.80 0.70,class:^(nm-connection-editor)$
      windowrulev2 = opacity 0.80 0.70,class:^(org.kde.polkit-kde-authentication-agent-1)$

      windowrulev2 = float,class:^(pavucontrol)$
      windowrulev2 = float,class:^(blueman-manager)$
      windowrulev2 = float,class:^(nm-applet)$
      windowrulev2 = float,class:^(nm-connection-editor)$
''
