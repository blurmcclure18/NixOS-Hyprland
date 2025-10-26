{config, pkgs, ...}:
{
  imports = [
    ./themes/tokyo-night-hyprlock.nix
  ];
  programs.hyprlock = {
    enable = true;

    settings = {
      #"source" = "$HOME/.config/hypr/themes/tokyo-night-hyprlock.conf";

      "source" = "$HOME/.config/hypr/wallust/wallust-hyprland.conf";

      background = {
        color = "$background";#"$color";
        path = "$HOME/.config/hypr/wallpaper_effects/.wallpaper_current";
        blur_passes = 3;
      };
      animations = {
        enabled = false;
      };
      input-field = {
        size = "600, 100";
        position = "0, 0";
        halign = "center";
        valign = "center";

        inner_color = "$background";#"$inner_color";
        outer_color = "$color3";#"$outer_color";
        outline_thickness = 4;

        font_family = "CaskaydiaMono Nerd Font";
        font_color = "$foreground";#"$font_color";

        placeholder_text = "Enter Password 󰈷 ";
        check_color = "$color6";
        fail_text = "<i>$PAMFAIL ($ATTEMPTS)</i>";

        rounding = 0;
        shadow_passes = 0;
        fade_on_empty = false;
      };
      auth = {
        "fingerprint:enabled" = true;
      };
    };

  };

}
