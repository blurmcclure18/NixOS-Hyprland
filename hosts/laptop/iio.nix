{ config, lib, pkgs, unstable, self, ... }:

{
  programs.iio-hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    jq
  ];
}
