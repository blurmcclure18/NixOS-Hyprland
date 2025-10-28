{ configs, pkgs, ... }:

{
  home.file.".config/alacritty/alacritty.toml".text = '' 
    [general]
    import = ["./colors.toml"]

    [env]
    TERM = "xterm-256color"
    
    [font]
    normal = { family = "CaskaydiaMono Nerd Font", style = "Regular" }
    bold = { family = "CaskaydiaMono Nerd Font", style = "Bold" }
    italic = { family = "CaskaydiaMono Nerd Font", style = "Italic" }
    size = 12
    
    [window]
    padding.x = 14
    padding.y = 14
    decorations = "None"
    
    [keyboard]
    bindings = [
    { key = "Insert", mods = "Shift", action = "Paste" },
    { key = "Insert", mods = "Control", action = "Copy" }
    ]
  '';
}

