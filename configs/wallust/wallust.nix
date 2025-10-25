{config, pkgs, ...}:

{
  programs.wallust = {

    enable = true;

    settings = {
      backend = "fastresize";
      color_space = "lch";
      palette = "dark";
     
      # Templates
      hypr.template = "colors-hyprland.conf";
      hypr.target = "~/.config/hypr/wallust/wallust-hyprland.conf";
      
      rofi.template = "colors-rofi.rasi";
      rofi.target = "~/.config/rofi/wallust/colors-rofi.rasi";
      
      
      waybar.template = "colors-waybar.css";
      waybar.target = "~/.config/waybar/wallust/colors-waybar.css";
    };
  };

  home.file.".config/wallust/templates/colors-hyprland.conf".text = ''
    # /* wallust template - colors-hyprland */ 

    $background = rgb({{background | strip}})
    $foreground = rgb({{foreground | strip}})
    $color0 = rgb({{color0 | strip}})
    $color1 = rgb({{color1 | strip}})
    $color2 = rgb({{color2 | strip}})
    $color3 = rgb({{color3 | strip}})
    $color4 = rgb({{color4 | strip}})
    $color5 = rgb({{color5 | strip}})
    $color6 = rgb({{color6 | strip}})
    $color7 = rgb({{color7 | strip}})
    $color8 = rgb({{color8 | strip}})
    $color9 = rgb({{color9 | strip}})
    $color10 = rgb({{color10 | strip}})
    $color11 = rgb({{color11 | strip}})
    $color12 = rgb({{color12 | strip}})
    $color13 = rgb({{color13 | strip}})
    $color14 = rgb({{color14 | strip}})
    $color15 = rgb({{color15 | strip}})
  '';

  home.file.".config/wallust/templates/colors-rofi.rasi".text = ''
    /* wallust template - colors-rofi */

    * {
    active-background: {{color12}};
    active-foreground: {{foreground}};
    normal-background: {{background}};
    normal-foreground: {{foreground}};
    urgent-background: {{color13}};
    urgent-foreground: {{foreground}};
    
    alternate-active-background: {{color11}};
    alternate-active-foreground: {{foreground}};
    alternate-normal-background: {{background}};
    alternate-normal-foreground: {{foreground}};
    alternate-urgent-background: {{background}};
    alternate-urgent-foreground: {{foreground}};
    
    selected-active-background: {{color13}};
    selected-active-foreground: {{foreground}};
    selected-normal-background: {{color13}};
    selected-normal-foreground: {{foreground}};
    selected-urgent-background: {{color12}};
    selected-urgent-foreground: {{foreground}};
    
    background-color: {{background}};
    background: rgba(0,0,0,0.7);
    foreground: {{foreground}};
    border-color: {{color12}};
    
    color0: {{color0}};
    color1: {{color1}};
    color2: {{color2}};
    color3: {{color3}};
    color4: {{color4}};
    color5: {{color5}};
    color6: {{color6}};
    color7: {{color7}};
    color8: {{color8}};
    color9: {{color9}};
    color10: {{color10}};
    color11: {{color11}};
    color12: {{color12}};
    color13: {{color13}};
    color14: {{color14}};
    color15: {{color15}};
    }
  '';

  home.file.".config/wallust/templates/colors-waybar.css".text = ''
     /* wallust template - colors-waybar */

     @define-color foreground {{foreground}};
     @define-color background {{background}};
     @define-color background-alt rgba({{background | rgb}},0.25);
     @define-color cursor {{cursor}};
     
     @define-color color0 {{color0}};
     @define-color color1 {{color1}};
     @define-color color2 {{color2}};
     @define-color color3 {{color3}};
     @define-color color4 {{color4}};
     @define-color color5 {{color5}};
     @define-color color6 {{color6}};
     @define-color color7 {{color7}};
     @define-color color8 {{color8}};
     @define-color color9 {{color9}};
     @define-color color10 {{color10}};
     @define-color color11 {{color11}};
     @define-color color12 {{color12}};
     @define-color color13 {{color13}};
     @define-color color14 {{color14}};
     @define-color color15 {{color15}}; 
  '';
}
