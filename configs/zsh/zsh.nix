{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    #shellAliases = {
    #    ".." = "cd ..";
    #    b = "btop";
    #    c = "clear";
    #    chypr = "cd ~/.dotfiles/configs/hyprland";
    #    n = "nvim";
    #    nzsh = "nvim ~/.dotfiles/configs/zsh.nix";
    #    nhypr = "nvim ~/.dotfiles/configs/hyprland/hyprland.conf";
    #    #nnix = "sudo nvim /etc/nixos/configuration.nix";
    #    nhome = "nvim ~/.dotfiles/home.nix";
    #    rebuild-switch = "sudo nixos-rebuild switch";
    #    rebuild-test = "sudo nixos-rebuild test";
    #    #rebuild-flake = "sudo nixos-rebuild switch --flake ~/.dotfiles";
    #    rebuild-home = "home-manager switch --flake ~/.dotfiles";
    #    ":vpn" = "sudo openconnect cva.uscourts.gov --user=alecmcclure --useragent='AnyConnect'";
    #};
  };

  home.file.".zshrc".source = ./.zshrc;
}
