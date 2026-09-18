{ config, lib, pkgs, unstable, self, ... }:

{
  services.keyd = {
    enable = true;
  
    keyboards.default = {
      ids = [ "*" ];
  
      settings = {
        main = {
          # Home-row mods
          f = "overloadt(alt, f, 200)";
          d = "overloadt(control, d, 200)";
          s = "overloadt(shift, s, 200)";
          a = "overloadt(meta, a, 200)";
  
          j = "overloadt(alt, j, 200)";
          k = "overloadt(control, k, 200)";
          l = "overloadt(shift, l, 200)";
          ";" = "overloadt(meta, ;, 200)";

          # Swap Caps Lock and Escape
          capslock = "esc";
          esc = "capslock";
  
          # V: tap = v, hold = Layer 1
          v = "overloadt(v_layer, v, 200)";
        };
  
        v_layer = {
          # Editing/navigation layer
          o = "backspace";
          i = "delete";
  
          h = "left";
          j = "down";
          k = "up";
          l = "right";
  
          u = "home";
          m = "end";
        };
      };
    };
  };
}
