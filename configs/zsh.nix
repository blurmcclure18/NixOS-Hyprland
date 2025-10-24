{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    shellAliases = {
        ".." = "cd ..";
        b = "btop";
        c = "clear";
        chypr = "cd ~/.config/hypr";
        n = "nvim";
        nzsh = "nvim ~/.zshrc";
        nhypr = "nvim ~/.config/hypr/hyprland.conf";
        nniri = "nvim ~/.config/niri/config.kdl";
        nnix = "sudo nvim /etc/nixos/configuration.nix";
        nhome = "nvim ~/.config/home-manager/home.nix";
        rebuild-switch = "sudo nixos-rebuild switch";
        rebuild-test = "sudo nixos-rebuild test";
        rebuild-flake = "nixos-rebuild switch --flake ~/.dotfiles";
        ":vpn" = "sudo openconnect cva.uscourts.gov --user=alecmcclure --useragent='AnyConnect'";
    };
  };
}
