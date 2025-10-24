{ configs, pkgs, ... }:

{

  imports = [
    ./binds.nix
    ./scripts/MediaCtrl.nix
    ./scripts/MyBeats.nix
  ];

 wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      
      "source" = "$HOME/.config/hypr/wallust/wallust-hyprland.conf";

      exec-once = [
        "waybar"
        "swww-daemon"
      ];

      env = [
        "XCURSOR_THEME,Adwaita"
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,50"
        "AQ_NO_MODIFIERS=1"
        "HYPRLAND_TRACE=1"

        "EDITOR,nvim"
        "GDK_SCALE,1"
        "QT_SCALE_FACTOR,1"
        "MOZ_ENABLE_WAYLAND,1"
      ];

      general = {
        border_size = 4;
        gaps_in = 2;
        gaps_out = 4; 
        "col.active_border" = "$color3";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 3;
        rounding_power = 5;
        active_opacity = 1.0;
        inactive_opacity = 0.85;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };
      
      animations = {
        enabled = true;

        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint" "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      ecosystem = {
        no_donation_nag = true;
        no_update_news = false;
      };

      input = {
        kb_layout = "us";
        kb_options = [
        "caps:swapescape"
        ];
        follow_mouse = 1;
        sensitivity = 0;

        touchpad = {
          natural_scroll = true;
        };
      };

      gestures = {
        workspace_swipe = true;
      };

      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        "tag +terminal, class:^(Alacritty)$"
        "opacity 0.95 0.8, tag:terminal*"
      ];
    };
  extraConfig = ''
    # Set Monitor Settings
    monitor=,preferred,auto,auto
    monitor=HDMI-A-1,3840x1080,auto,auto
    monitor=DP-1,highres,auto,1.6
    monitor=DP-2,highres,auto,1.6

    # Turn off laptop screen when lid is closed
    bindl = , switch:off:Lid Switch,exec,hyprctl keyword "eDP-1,preferred,auto,1"
    bindl = , switch:on:Lid Switch,exec,hyprctl keyword "eDP-1,disable"

    # For passthrough keyboard into a VM
    bind = $mainMod SUPER, P, submap, passthru
    submap = passthru

    # to unbind
    bind = $mainMod SUPER, P, submap, reset
    submap = reset
  '';
  };
}
