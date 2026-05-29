{ config, lib, pkgs, inputs, unstable, ... }:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  imports = [
    ./configs
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "alec";
  home.homeDirectory = "/home/alec";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # udiskie service
  services.udiskie = {
    enable = true;
    settings = {
      program_options = {
	  file_manager = "${pkgs.nautilus}/bin/nautilus";
      };
    };
  };

  fonts.fontconfig.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs;[
    calc
    cava
    chromium
    dejavu_fonts
    file-roller
    fontconfig
    grim
    mediawriter
    nautilus
    nwg-look
    obsidian
    omnissa-horizon-client
    remmina
    slurp
    #spotify-player
    swappy
    tokyonight-gtk-theme
    usbutils
    ytui-music
  ];

  home.sessionVariables = {
    HYPRLAND_CONFIG = "${config.home.homeDirectory}/.dotfiles/configs/hyprland/hyprland.conf";
    FONTCONFIG_PATH = "/run/current-system/sw/etc/fonts";
    GTK_THEME = "Tokyonight-Dark-B";
  };

  # Home Manager can also manage your environment variables through
  # "home.sessionVariables". These will be explicitly sourced when using a
  # shell provided by Home Manager.
  home.sessionVariables = {
     EDITOR = "nvim";
  };

  # Testing Lock on wake from suspend
  systemd.user.services."lock-on-sleep" = {
    Service = {
      Type = "forking";
      ExecStart = "${pkgs.hyprlock}/bin/hyprlock";
    };
    Install = {
      WantedBy = ["sleep.target"];
    };
    Unit = {
      Description = "Lock screen before suspend";
      Before = ["sleep.target"];
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
