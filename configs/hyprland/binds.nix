{configs, pkgs, ...}:

{
  wayland.windowManager.hyprland = {
    settings = {

      "$mainMod" = "ALT";
      "$browser" = "firefox";
      "$terminal" = "alacritty";
      "$filemanager" = "thunar";
      "$menu" = "rofi -show drun -modi drun,filebrowser,run,window";

      bind = [
        "$mainMod, N, exec, $browser"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, SPACE, exec, $menu"
        "$mainMod, RETURN, exec, $terminal"
        "$mainMod, Q, killactive,"
        "$mainMod, I, togglesplit"
        "$mainMod, F, fullscreen"
        "$mainMod, P, exec, wlogout"
        "$mainMod, R, exec, $HOME/.config/hypr/scripts/RofiThemeSelector-modified.sh"
        "$mainMod, W, exec, $HOME/.config/hypr/scripts/WallpaperSelect.sh"
        "$mainMod SHIFT, Q, exit,"
        "$mainMod SHIFT, P, exec, $HOME/.config/hypr/scripts/RofiPowerProfiles-selector.sh"
        "$mainMod SHIFT, F, fullscreen"
        "$mainMod SHIFT, R, exec, pkill waybar && waybar"
        "$mainMod SHIFT, ESC, exit"

        "SUPER, L, exec, hyprlock"

        # Play Music
        "CTRL SHIFT, M, exec, $HOME/.config/hypr/scripts/MyBeats.sh"

        # Move focus with mainMod + vim keys
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"

        # Move window with mainMod + vim keys
        "$mainMod SHIFT, H, movewindow, l"
        "$mainMod SHIFT, L, movewindow, r"
        "$mainMod SHIFT, K, movewindow, u"
        "$mainMod SHIFT, J, movewindow, d"

        # Resize window with mainMod + vim keys
        "$mainMod CTRL, H, resizeactive, -50 0"
        "$mainMod CTRL, L, resizeactive, 50 0"
        "$mainMod CTRL, K, resizeactive, 0 -50"
        "$mainMod CTRL, J, resizeactive, 0 50"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Switch workspaces with comma, period, or M for eMpty workspace
        "$mainMod, comma, workspace, e-1"
        "$mainMod, period, workspace, e+1"
        "$mainMod, M, workspace, empty"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Move active window to a workspace with mainMod + comma, period, or M for eMpty workspace
        "$mainMod SHIFT, comma, movetoworkspace, r-1"
        "$mainMod SHIFT, period, movetoworkspace, r+1"
        "$mainMod SHIFT, M, movetoworkspace, empty"

        # Scroll though existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      bindm = [
      # Move/Resize windows with mainMod + LMB/RMB and dragging
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        # Laptop multimedia keys for volume and LCD brightness
        ",XF86AudioMute,        exec, $HOME/.config/hypr/scripts/MyVolume.sh --toggle"
        ",XF86AudioMicMute,     exec, $HOME/.config/hypr/scripts/MyVolume.sh --toggle_mic"
        ",XF86AudioRaiseVolume, exec, $HOME/.config/hypr/scripts/MyVolume.sh --inc"
        ",XF86AudioLowerVolume, exec, $HOME/.config/hypr/scripts/MyVolume.sh --dec"
        ",XF86MonBrightnessUp,  exec, $HOME/.config/hypr/scripts/MyBrightness.sh --up"
        ",XF86MonBrightnessDown,exec, $HOME/.config/hypr/scripts/MyBrightness.sh --down"
      ];

      bindl = [
        # Requires playerctl
        ", XF86AudioPause,exec, $HOME/.config/hypr/scripts/MediaCtrl.sh --pause #playerctl play-pause"
        ", XF86AudioPlay, exec, $HOME/.config/hypr/scripts/MediaCtrl.sh --pause #playerctl play-pause"
        ", XF86AudioStop, exec, $HOME/.config/hypr/scripts/MediaCtrl.sh --stop #playerctl stop"
        ", XF86AudioNext, exec, $HOME/.config/hypr/scripts/MediaCtrl.sh --nxt #playerctl next"
        ", XF86AudioPrev, exec, $HOME/.config/hypr/scripts/MediaCtrl.sh --prv #playerctl previous"
      ];
    };
  };
}
