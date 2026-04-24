{ configs, pkgs, ... }:

{
  home.file.".config/nvim/init.lua".source = ./init.lua;

  # Replace Surround.lua in mini.nvim
  home.file.".local/share/nvim/lazy/mini.nvim/mini/surround.lua".source = ./surround.lua;

}

