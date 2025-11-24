{config, pkgs, ...}:

{
  imports = [
    ./templates
  ];

  programs.wallust = {

    enable = true;
  };

  home.file.".config/wallust/wallust.toml".text = ''
    backend = "fastresize"
    color_space = "lch"
    palette = "dark"

    [templates]
    alacritty.template = 'colors-alacritty.toml'
    alacritty.target = '~/.config/alacritty/colors.toml'

    ghostty.template = 'colors-ghostty'
    ghostty.target = '~/.config/ghostty/themes/wallust'

    hypr.template = 'colors-hyprland.conf'
    hypr.target = '~/.config/hypr/wallust/wallust-hyprland.conf'
    
    hypridle.template = 'colors-hypridle.conf'
    hypridle.target = '~/.config/hypr/wallust/wallust-hypridle.conf'

    rofi.template = 'colors-rofi.rasi'
    rofi.target = '~/.config/rofi/wallust/colors-rofi.rasi'
    
    
    waybar.template = 'colors-waybar.css'
    waybar.target = '~/.config/waybar/wallust/colors-waybar.css'

  '';
}
